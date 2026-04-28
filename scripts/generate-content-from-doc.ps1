Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

Set-Location (Join-Path $PSScriptRoot "..")

$xmlPath = ".tmp_doc_extract\unzipped\word\document.xml"
if (-not (Test-Path $xmlPath)) {
    throw "Missing extracted DOCX XML at $xmlPath."
}

[xml]$doc = Get-Content -Raw $xmlPath
$ns = New-Object System.Xml.XmlNamespaceManager($doc.NameTable)
$ns.AddNamespace("w", "http://schemas.openxmlformats.org/wordprocessingml/2006/main")

function Normalize-Text([string]$text) {
    if ([string]::IsNullOrWhiteSpace($text)) { return "" }
    $t = $text.Trim()
    $t = $t -replace "\s+", " "
    return $t
}

function Get-Slug([string]$text) {
    $s = $text.ToLowerInvariant()
    $s = $s -replace "&", " and "
    $s = $s -replace "[^a-z0-9\.\s-]", ""
    $s = $s -replace "\s+", "-"
    $s = $s -replace "-+", "-"
    return $s.Trim("-")
}

function Get-TitleSlug([string]$text) {
    $clean = $text -replace "[^A-Za-z0-9\s-]", " "
    $parts = $clean -split "[\s-]+" | Where-Object { -not [string]::IsNullOrWhiteSpace($_) }
    $normalized = foreach ($part in $parts) {
        if ($part -cmatch "^[A-Z0-9]{2,}$") {
            $part
        }
        else {
            $lower = $part.ToLowerInvariant()
            if ($lower.Length -eq 1) {
                $lower.ToUpperInvariant()
            }
            else {
                $lower.Substring(0, 1).ToUpperInvariant() + $lower.Substring(1)
            }
        }
    }
    return ($normalized -join "-")
}

$paras = $doc.SelectNodes("//w:body/w:p", $ns)
$sections = New-Object System.Collections.Generic.List[object]
$currentSection = $null
$currentSub = $null

foreach ($p in $paras) {
    $styleNode = $p.SelectSingleNode("w:pPr/w:pStyle/@w:val", $ns)
    $style = if ($styleNode) { $styleNode.Value } else { "" }

    $textNodes = $p.SelectNodes(".//w:t", $ns)
    $text = (($textNodes | ForEach-Object { $_."#text" }) -join "")
    $text = Normalize-Text $text
    if ([string]::IsNullOrWhiteSpace($text)) { continue }

    if ($style -eq "Heading3") {
        $num = $null
        $title = $text
        if ($text -match "^(\d+)\.\s*(.+)$") {
            $num = [int]$matches[1]
            $title = $matches[2]
        }

        $currentSection = [ordered]@{
            Number = $num
            Title = $title
            RawHeading = $text
            Body = New-Object System.Collections.Generic.List[string]
            Subsections = New-Object System.Collections.Generic.List[object]
        }
        $sections.Add($currentSection)
        $currentSub = $null
        continue
    }

    if ($style -eq "Heading4") {
        if (-not $currentSection) { continue }

        $subNum = $null
        $subTitle = $text
        if ($text -match "^(\d+\.\d+)\s+(.+)$") {
            $subNum = $matches[1]
            $subTitle = $matches[2]
        }

        $currentSub = [ordered]@{
            Number = $subNum
            Title = $subTitle
            RawHeading = $text
            Body = New-Object System.Collections.Generic.List[string]
        }
        $currentSection.Subsections.Add($currentSub)
        continue
    }

    if ($currentSub) {
        $currentSub.Body.Add($text)
    }
    elseif ($currentSection) {
        $currentSection.Body.Add($text)
    }
}

$contentRoot = "content"
Get-ChildItem $contentRoot -Directory |
    Where-Object { $_.Name -match "^\d+-" } |
    ForEach-Object { Remove-Item -Recurse -Force $_.FullName }

$fallbackNumber = 1
foreach ($section in $sections) {
    $sectionNumber = if ($null -ne $section.Number) {
        [string]$section.Number
    }
    else {
        [string](12 + $fallbackNumber)
    }

    if ($null -eq $section.Number) {
        $fallbackNumber++
    }

    $sectionTitleForFolder = if ($section.Title -eq "Preparation Steps") { "Preparation" } else { $section.Title }
    $sectionSlugTitle = Get-TitleSlug $sectionTitleForFolder
    $sectionFolderName = "$sectionNumber-$sectionSlugTitle"
    $sectionPath = Join-Path $contentRoot $sectionFolderName
    New-Item -ItemType Directory -Path $sectionPath -Force | Out-Null

    $sectionLines = New-Object System.Collections.Generic.List[string]
    $sectionLines.Add("---")
    $sectionLines.Add("title : `"$($section.Title)`"")
    $sectionLines.Add("date: `"2000-01-01`"")
    $sectionLines.Add("weight : $sectionNumber")
    $sectionLines.Add("chapter : false")
    $sectionLines.Add("pre : `" <b>  $sectionNumber. </b> `"")
    $sectionLines.Add("---")
    $sectionLines.Add("")

    foreach ($line in $section.Body) {
        $sectionLines.Add($line)
    }

    if ($section.Subsections.Count -gt 0) {
        if ($section.Body.Count -gt 0) {
            $sectionLines.Add("")
        }
        $sectionLines.Add("## Subsections")
        foreach ($sub in $section.Subsections) {
            $subNumber = if ($sub.Number) { $sub.Number } else { "$sectionNumber.0" }
            $subSlug = Get-TitleSlug $sub.Title
            $subFolder = "$subNumber-$subSlug"
            $sectionLines.Add("- [$subNumber $($sub.Title)]($subFolder/)")
        }
    }

    Set-Content -Path (Join-Path $sectionPath "_index.md") -Value $sectionLines -Encoding UTF8

    foreach ($sub in $section.Subsections) {
        $subNumber = if ($sub.Number) { $sub.Number } else { "$sectionNumber.0" }
        $subSlug = Get-TitleSlug $sub.Title
        $subFolder = "$subNumber-$subSlug"
        $subPath = Join-Path $sectionPath $subFolder
        New-Item -ItemType Directory -Path $subPath -Force | Out-Null

        $subLines = New-Object System.Collections.Generic.List[string]
        $subLines.Add("---")
        $subLines.Add("title : `"$subNumber $($sub.Title)`"")
        $subLines.Add("date: `"2000-01-01`"")
        $subLines.Add("weight : 1")
        $subLines.Add("chapter : false")
        $subLines.Add("---")
        $subLines.Add("")

        if ($sub.Body.Count -gt 0) {
            $subLines.Add("## Steps")
            foreach ($line in $sub.Body) {
                $subLines.Add("- $line")
            }
        }
        else {
            $subLines.Add("Content to be added.")
        }

        Set-Content -Path (Join-Path $subPath "_index.md") -Value $subLines -Encoding UTF8
    }
}

Write-Host "Generated content folders:"
Get-ChildItem $contentRoot -Directory | Sort-Object Name | Select-Object -ExpandProperty Name
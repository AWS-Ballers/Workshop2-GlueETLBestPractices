---
title : "4.1 Create ETL Job with Glue Studio"
date: "2000-01-01"
weight : 1
chapter : false
---

## Steps
- Use visual editor to create job
![Figure 4.1.1](/images/4/Figure4.1.1.png)
- Figure 4.1.1: [Insert image here]
![Figure 4.1.2](/images/4/Figure4.1.2.png)
- Figure 4.1.2: [Insert image here]
![Figure 4.1.3](/images/4/Figure4.1.3.png)
- Figure 4.1.3: [Insert image here]
- Configure data source (cataloged tables)
![Figure 4.1.4](/images/4/Figure4.1.4.png)
- Figure 4.1.4: [Insert image here]
![Figure 4.1.5](/images/4/Figure4.1.5.png)
- Figure 4.1.5: [Insert image here]
![Figure 4.1.6](/images/4/Figure4.1.6.png)
- Figure 4.1.6: [Insert image here]
- Choose IAM as ETLBestPracticeRole
![Figure 4.1.7](/images/4/Figure4.1.7.png)
- Figure 4.1.7: [Insert image here]
- Make 1 more for order
![Figure 4.1.8](/images/4/Figure4.1.8.png)
- Figure 4.1.8: [Insert image here]
- Join the 2 table
![Figure 4.1.9](/images/4/Figure4.1.9.png)
- Figure 4.1.9: [Insert image here]
![Figure 4.1.10](/images/4/Figure4.1.10.png)
- Figure 4.1.10: [Insert image here]
- Add transformations:
- Change schema (rename columns) to remove unnecessary column if you want
![Figure 4.1.11](/images/4/Figure4.1.11.png)
- Figure 4.1.11: [Insert image here]
![Figure 4.1.12](/images/4/Figure4.1.12.png)
- Figure 4.1.12: [Insert image here]
- Configure data target (S3 Parquet)
- Search for Target Catalog
![Figure 4.1.13](/images/4/Figure4.1.13.png)
- Figure 4.1.13: [Insert image here]
- Choose the right dataset and table
![Figure 4.1.14](/images/4/Figure4.1.14.png)
- Figure 4.1.14: [Insert image here]
- Alter the name for better visualing
![Figure 4.1.15](/images/4/Figure4.1.15.png)
- Figure 4.1.15: [Insert image here]

---
title : "9.2 IAM Best Practices"
date: "2000-01-01"
weight : 1
chapter : false
---

## Steps
- Review IAM role permissions:
- Audit GlueWorkshopRole policies
- Remove unnecessary permissions
- Apply least privilege principle:
- Grant only required S3 bucket access
- Limit Glue API permissions
- Restrict CloudWatch log access
- Enable CloudTrail logging:
- Track all Glue API calls
- Monitor for unauthorized access
- Set up audit reports
- Review access patterns:
- Who is running jobs?
- Which resources are accessed?
- Identify anomalies

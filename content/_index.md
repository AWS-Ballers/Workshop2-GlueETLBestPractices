---
title: "Workshop"
date: "2000-01-01"
weight: 05
chapter: false
pre: " <b>  </b> "
---

# AWS Automated Incident Response and Forensics System Setup

#### Overview

This guide provides a complete, step-by-step procedure for deploying our automated incident response and forensic system in AWS. This system leverages **CloudTrail**, **GuardDuty**, **VPC Flow Logs**, **Kinesis Firehose**, **Glue**, **Athena**, and **Lambda** functions orchestrated by **AWS Step Functions** to automatically detect, analyze, and quarantine compromised resources like EC2 instances and IAM users. Futher log forensics capacity is added by setting up a **Security Dashboard** hosted on S3 and accessed via **CloudFront** and **Cognito**, query log using **API Gateway** and **Lambda**.



#### Content
1. [Overview](1-Workshop-overview/)
2. [Prerequisites](2-Prerequisites)
3. [Phase 1: Foundation Setup](3-Foundation-Setup/)
4. [Phase 2: Monitoring Setup](4-Monitoring-Setup/)
5. [Phase 3: Processing Setup](5-Processing-Setup/)
6. [Phase 4: Automation Setup](6-Automation-Setup/)
7. [Phase 5: Dashboard Setup](7-Dashboard-Setup/)
8. [Verify](8-Verify-Setup/)
9. [Use CDK](9-Use-CDK/)
10. [Cleanup](10-Cleanup/)
11. [Appendices](11-Appendices/)
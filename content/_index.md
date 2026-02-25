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
1. [Introduction](1-Introduction/)
2. [Preparation](2-Preparation/)
3.  [Clean up resources](10-Cleanup/)
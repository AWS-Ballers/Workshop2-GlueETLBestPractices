---
title: "Workshop"
date: "2000-01-01"
weight: 05
chapter: false
pre: " <b>  </b> "
---

# Thiết lập hệ thống phản hồi sự cố tự động và pháp y số trên AWS

#### Tổng quan

Hướng dẫn này cung cấp quy trình từng bước hoàn chỉnh để triển khai hệ thống phản hồi sự cố và điều tra số (forensics) tự động của chúng tôi trên AWS. Hệ thống này tận dụng **CloudTrail**, **GuardDuty**, **VPC Flow Logs**, **Kinesis Firehose**, **Glue**, **Athena**, và **Lambda** functions được điều phối bởi **AWS Step Functions** để tự động phát hiện, phân tích và cách ly các tài nguyên bị xâm phạm như EC2 instances và IAM users. Khả năng điều tra log sâu hơn được bổ sung bằng cách thiết lập **Security Dashboard** lưu trữ trên S3 và truy cập qua **CloudFront** và **Cognito**, truy vấn log sử dụng **API Gateway** và **Lambda**.

#### Nội dung
1. [Giới thiệu](1-Introduction/)
2. [Các bước chuẩn bị](2-Preparation/)
3. [Dọn dẹp](10-Cleanup/)
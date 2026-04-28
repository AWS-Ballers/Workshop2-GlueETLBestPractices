---
title : "5.3 Add Data Quality Rules"
date: "2000-01-01"
weight : 1
chapter : false
---

## Steps
- Implementing data quality rules allows you to automatically validate the completeness and accuracy of your datasets during the processing pipeline.
- Go to S3 and create glue-workshop-fails-group and glue-workshop-ruleset-outcomes buckets with the default setting except the bucket name choose Account Regional namespace
![Figure 5.3.1](/images/5/Figure5.3.1.png)
- Figure 5.3.1: [Insert image here]
- Add two Evaluate Data Quality nodes
![Figure 5.3.2](/images/5/Figure5.3.2.png)
- Figure 5.3.2: [Insert image here]
- Go to the ETLGlueBestPracticesS3Policy and add the two bucket just created to the Resources
![Figure 5.3.3](/images/5/Figure5.3.3.png)
- Figure 5.3.3: [Insert image here]
- Put the Evaluate Data Quality nodes between the Join and SQL Query node
![Figure 5.3.4](/images/5/Figure5.3.4.png)
- Figure 5.3.4: [Insert image here]
- In Evaluate Data Quality node check the two box Original data and Data quality result at Data quality transform output section
![Figure 5.3.5](/images/5/Figure5.3.5.png)
- Figure 5.3.5: [Insert image here]
- The check box will create two output node
![Figure 5.3.6](/images/5/Figure5.3.6.png)
- Figure 5.3.6: [Insert image here]
- At the rowLevelOutcomes node add a Conditional Router node with the following setting
![Figure 5.3.7](/images/5/Figure5.3.7.png)
- Figure 5.3.7: [Insert image here]
- The Condition Route node will create two follow node default_group and output_group_1, change the name of the output_group_1 in Condition Route node to FAILS_GROUP
![Figure 5.3.8](/images/5/Figure5.3.8.png)
- Figure 5.3.8: [Insert image here]
- Link the default_group to the SQL Query node
![Figure 5.3.9](/images/5/Figure5.3.9.png)
- Figure 5.3.9: [Insert image here]
- With the FAILS_GROUP node add a Amazon S3 target node after it with the following setting
![Figure 5.3.10](/images/5/Figure5.3.10.png)
- Figure 5.3.10: [Insert image here]
![Figure 5.3.11](/images/5/Figure5.3.11.png)
- Figure 5.3.11: [Insert image here]
- At the ruleOutcomes node add the Amazon S3 target node after it with the following setting
![Figure 5.3.12](/images/5/Figure5.3.12.png)
- Figure 5.3.12: [Insert image here]
![Figure 5.3.13](/images/5/Figure5.3.13.png)
- Figure 5.3.13: [Insert image here]
- Add validation rules to the ruleset editor at the Evaluate Data Quality node:
- Completeness checks (non-null fields)
- Completeness "customer_id" >= 1.0,
- Completeness "customer_unique_id" >= 1.0,
- Completeness "customer_city" >= 1.0,
- Completeness "customer_state" >= 1.0,
- Completeness "order_id" >= 1.0,
- Completeness "customer_id" >= 1.0,
- Completeness "order_status" >= 1.0,
- Completeness "order_purchase_timestamp" >= 1.0,
- Uniqueness checks (primary keys)
- IsUnique "order_id",
- Range checks (dates, amounts)
- ColumnValues "customer_zip_code_prefix" between 1000 and 99999,
- ColumnValues "order_status" in ["delivered","shipped","canceled","unavailable","invoiced","processing","created","approved"],
- ColumnLength "customer_state" = 2
![Figure 5.3.14](/images/5/Figure5.3.14.png)
- Figure 5.3.14: [Insert image here]
- Save the ETL job
![Figure 5.3.15](/images/5/Figure5.3.15.png)
- Figure 5.3.15: [Insert image here]
- Run data quality evaluation
![Figure 5.3.16](/images/5/Figure5.3.16.png)
- Figure 5.3.16: [Insert image here]
- Review quality metrics
![Figure 5.3.17](/images/5/Figure5.3.17.png)
- Figure 5.3.17: [Insert image here]
![Figure 5.3.18](/images/5/Figure5.3.18.png)
- Figure 5.3.18: [Insert image here]

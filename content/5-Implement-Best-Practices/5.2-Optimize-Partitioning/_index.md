---
title : "5.2 Optimize Partitioning"
date: "2000-01-01"
weight : 1
chapter : false
---

## Steps
- Partitioning organizes your data into logical subfolders based on specific keys, such as date, to significantly improve query performance and reduce data scanning costs
- Add partition keys (year, month, day)
- Figure 5.2.1: [Insert image here]
- Since our test dataset timestamp is in format 11/14/2017 16:08 we will have to split to year, month and date using SQL Transform node in ETL job
- Figure 5.2.2: [Insert image here]
- Connect the parent node of SQL Transform to Join node and Change Schemas parent node to SQL Transform
- Figure 5.2.3: [Insert image here]
- Add this script to spit the timestamp
- SELECT *,
- cast(year(to_timestamp(order_purchase_timestamp, 'M/d/yyyy H:mm')) as string) as year,
- cast(month(to_timestamp(order_purchase_timestamp, 'M/d/yyyy H:mm')) as string) as month,
- cast(day(to_timestamp(order_purchase_timestamp, 'M/d/yyyy H:mm')) as string) as day
- FROM myDataSource
- Figure 5.2.4: [Insert image here]
- Check the result
- Figure 5.2.5: [Insert image here]
- Add partition key in Clean node
- Figure 5.2.6: [Insert image here]
- Save the ETL job
- Figure 5.2.7: [Insert image here]
- Reset Bookmark
- Figure 5.2.8: [Insert image here]
- Run the ETL job again
- Figure 5.2.9: [Insert image here]
- Check result in S3
- Figure 5.2.10: [Insert image here]
- Figure 5.2.11: [Insert image here]
- Figure 5.2.12: [Insert image here]
- Configure partition projection by editing Clean table properties
- For the storage.location.template use this value:
- s3://[Your Transform S3 Bucket]/year=${year}/month=${month}/day=${day}
- Figure 5.2.13: [Insert image here]
- Verify query performance improvement
- Without Partition
- Figure 5.2.14: [Insert image here]
- With Partition
- Figure 5.2.15: [Insert image here]



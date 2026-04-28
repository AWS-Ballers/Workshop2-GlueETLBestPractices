---
title : "5.1 Enable Job Bookmarks"
date: "2000-01-01"
weight : 1
chapter : false
---

## Steps
- Job Bookmarks are a feature used to maintain state information and track data that has already been processed during previous runs of an ETL job. Their primary purpose is to enable incremental data loading, ensuring that the job only processes new data added since the last successful run, which prevents reprocessing old records and improves overall efficiency.
- Configure job bookmarks for incremental processing
![Figure 5.1.1](/images/5/Figure5.1.1.png)
- Figure 5.1.1: [Insert image here]
![Figure 5.1.2](/images/5/Figure5.1.2.png)
- Figure 5.1.2: [Insert image here]
- Because our raw data is stored in S3, enabling the Job Bookmark is all we need to do for incremental loads. Glue automatically tracks the S3 file metadata, so we don't have to manually define bookmark keys.
- Run the ETL job for the bookmark to track the latest process
![Figure 5.1.3](/images/5/Figure5.1.3.png)
- Figure 5.1.3: [Insert image here]
- Check result using Athena
![Figure 5.1.4](/images/5/Figure5.1.4.png)
- Figure 5.1.4: [Insert image here]
- Test with new data uploads
![Figure 5.1.5](/images/5/Figure5.1.5.png)
- Figure 5.1.5: [Insert image here]
![Figure 5.1.6](/images/5/Figure5.1.6.png)
- Figure 5.1.6: [Insert image here]
- Run ETL job again
![Figure 5.1.7](/images/5/Figure5.1.7.png)
- Figure 5.1.7: [Insert image here]
- Verify only new records are processed by checking duplicate rows. The query should only output the new data in the new dataset
![Figure 5.1.8](/images/5/Figure5.1.8.png)
- Figure 5.1.8: [Insert image here]


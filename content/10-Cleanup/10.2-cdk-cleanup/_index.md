---
title : "CDK Cleanup"
date: "2000-01-01"
weight : 02
chapter : false
pre : " <b> 10.2. </b> "
---
##  Clean up (CDK)

This guide ensures you correctly decommission all resources provisioned by the AWS CDK stack and clean up manually created data to avoid ongoing charges.

### Phase 1: Manual Data Cleanup (Before CDK Destroy)

The CDK automatically deletes most resources but fails in deleting content from S3 Buckets. All log buckets are set to retain after destroying, except for `aws-incident-response-automation-dashboard` bucket. You must empty the contents of the `aws-incident-response-automation-dashboard` bucket before running the `cdk-destroy` command

**Instructions for Emptying Buckets:**

1.  Open the **Amazon S3 Console** in your browser.
2.  For the `aws-incident-response-automation-dashboard` bucket:
    * Click on the bucket name.
    * Navigate to the **"Objects"** tab.
    * Click the **"Empty"** button.
    * Follow the prompts to confirm the permanent deletion of all objects.

---

### Phase 2: CDK Stack Destruction

This step uses the CDK CLI to destroy all resources provisioned by the CloudFormation stack.

1.  **Ensure Virtual Environment is Active**
    * If you deactivated your Python environment, re-activate it (e.g., `source .venv/bin/activate`).

2.  **Navigate to the Project Root**
    * Ensure you are in the main directory where the `cdk.json` file is located.

3.  **Execute the Destroy Command**
    * Run the command to destroy all deployed stacks. When prompted, type **`y`** to approve the deletion.
        ```bash
        $ cdk destroy --all
        ```
---

### Phase 3: Post-Destruction Cleanup

This step addresses remaining manual cleanup of lingering resources.

1.  **Delete Remaining S3 Buckets**
    * The `cdk destroy` command should remove the **empty** S3 buckets. If any remain (due to final checks or service protections), delete them now via the S3 Console.

2.  **Disable Amazon GuardDuty**
    * Go to **GuardDuty Console** → **Settings** → **General**.
    * Verify the service is disabled to ensure billing stops.

3.  **Remove Cognito User and Pool**
    * Go to **Cognito Console** → **User pools**.
    * Delete the test user you created.
    * Delete the User Pool created for the dashboard.

4.  **Remove SES Identity**
    * Go to **Amazon SES Console** → **Verified Identities**.
    * Delete the sender email identity (`sender_email`) you verified.

5.  **Deactivate Virtual Environment**
    * Deactivate the Python virtual environment:
        ```bash
        $ deactivate
        ```
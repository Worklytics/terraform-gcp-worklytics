# Create Psoxy Connections Example

This example illustrates how to create Psoxy connections in Worklytics via its Tenant API.

Assuming you've set up a Psoxy instance in AWS, the example will create a GCP Service Account (SA)
to get an ID Token used to authenticate with the Tenant API, and a shell script that creates a
Psoxy Connection for each one of the Data Sources configured in your Psoxy instance.

Terraform variables used:

```hcl
worklytics_tenant_id = "116863361842113328137"
user_principal_email = "johndoe@acme.com"
psoxy_connections = [{
  integration = "data-source-psoxy",
  kind = "GCP",
  endpoint = "https://us-central-1-my-worklytics-psoxy.cloudfunctions.net/data-source-psoxy",
}]
```

- `worklytics_tenant_id` is the unique ID of your Worklytics tenant (obtain from the Worklytics Web App).
- `service_account_id` the account ID used to generate the SA email address. This is the email that
  must be registered as `DataConnectionAdmin` in the Worklytics Web App.
- `project_id` is the GCP project ID where the service account will be created.
- `psoxy_connections` is a collection of the attributes for each Data Source configured in your Psoxy instance.

**Once the Terraform script is executed, and the shell script is created, make sure that the SA
email is registered as `DataConnectionAdmin` in the Worklytics Web App.**

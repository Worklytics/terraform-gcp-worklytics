resource "local_file" "worklytics_tenant_api_script_file" {
  content = <<EOT
#!/bin/bash

# Script to set up a Psoxy connection for ${var.psoxy_connection.integration}

SERVICE_ACCOUNT="${var.service_account_email}"

# If service account (SA) is not provided, don't impersonate and assume that current credentials
# are already set for a valid SA
if [ -z "$SERVICE_ACCOUNT" ]; then
  TOKEN=`gcloud auth print-identity-token --audiences="https://app.worklytics.co"`
else
  TOKEN=`gcloud auth print-identity-token \
    --impersonate-service-account=$SERVICE_ACCOUNT \
    --audiences="https://app.worklytics.co" \
    --include-email`
fi

echo "ID Token Info:"
curl "https://oauth2.googleapis.com/tokeninfo?id_token=$TOKEN"

curl -X POST https://${var.tenant_api_host}/tenant-api/data-connections \
  -H "Authorization: Bearer $TOKEN" \
  -H "x-worklytics-tenant-id: ${var.worklytics_tenant_id}"\
  -H "Content-Type: application/json" \
  -d '{
       "integrationId": "${var.psoxy_connection.integration}",
        "settings": {
          "PROXY_DEPLOYMENT_KIND": "${var.psoxy_connection.kind}",
          "PROXY_ENDPOINT": "${var.psoxy_connection.endpoint}"
        }
     }'
EOT
  filename = "${coalesce(var.psoxy_connection_script_path, path.module)}/create_${var.psoxy_connection.integration}_connection.sh"
  file_permission = "0755"
}

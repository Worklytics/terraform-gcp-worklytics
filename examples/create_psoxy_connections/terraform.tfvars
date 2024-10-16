worklytics_tenant_id = "116863361842113328137" # SA unique ID of "worklytics-proxy-only" ORG in DEV
project_id           = "psoxy-dev-david"
service_account_id   = "wks-s185-test"
psoxy_connections = [{
  integration = "asana-psoxy",
  kind        = "GCP",
  endpoint    = "https://us-central1-psoxy-dev-david.cloudfunctions.net/psoxy-asana",
}]
tenant_api_host = "discrete-scarcely-panda.ngrok-free.app"

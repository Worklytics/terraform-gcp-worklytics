# TODO modules referenced by relative path until published in registry, or in a public repo

# create the SA needed to auth with the Worklytics Tenant API
module "tenant_api_auth" {
  source = "../../modules/sa_tenant_api_auth"

  service_account_id = var.service_account_id
  project_id         = var.project_id
}

# create script files for each Psoxy connection
module "create_psoxy_connection_script" {
  source = "../../modules/psoxy_connection"

  for_each = {
    for psoxy_connection in var.psoxy_connections :
    psoxy_connection.integration => psoxy_connection
  }
  psoxy_connection = {
    integration = each.value.integration
    kind        = each.value.kind
    endpoint    = each.value.endpoint
  }
  psoxy_connection_script_path = path.module
  service_account_email        = module.tenant_api_auth.worklytics_tenant_api_sa
  worklytics_tenant_id         = var.worklytics_tenant_id
  tenant_api_host              = var.tenant_api_host
}

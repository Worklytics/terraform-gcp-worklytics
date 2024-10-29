output "worklytics_tenant_api_sa" {
  value = module.tenant_api_auth.worklytics_tenant_api_sa
}

output "worklytics_tenant_api_scripts" {
  value = { for key, value in module.create_psoxy_connection_script : key => value.worklytics_tenant_api_script_file.filename }
}

variable "service_account_id" {
  type        = string
  description = "Account ID used to generate the SA email address, 6-30 characters long."
  default     = "worklytics-tenant-api"
}

variable "project_id" {
  type        = string
  description = "ID of the GCP project where you want to create the service account."
}

variable "worklytics_tenant_id" {
  type        = string
  description = "Numeric ID of your Worklytics tenant's service account (obtain from Worklytics Web App)."

  validation {
    condition     = var.worklytics_tenant_id == null || can(regex("^\\d{21}$", var.worklytics_tenant_id))
    error_message = "`worklytics_tenant_id` must be a 21-digit numeric value. (or `null`, for pre-production use case where you don't want external entity to be allowed to assume the role)."
  }
}

variable "tenant_api_host" {
  type        = string
  description = "Host of the Worklytics Tenant API: the domain by which Cognito will refer users."
  default     = "intl.worklytics.co"
}

variable "psoxy_connections" {
  type = list(object({
    integration         = string           # The integration ID to use for this connection.
    endpoint            = optional(string) # The endpoint of the Cloud Function (Work Data connections use-case).
    bucket              = optional(string) # The Cloud Storage bucket (Bulk Data connections use-case).
    parser_id           = optional(string) # Bulk Data connections only.
    github_organization = optional(string) # GitHub Connections only.
  }))
  description = "The connection details for Psoxy connections to be created via Worklytics Tenant API."
}

variable "psoxy_connection_script_path" {
  type        = string
  description = "Where to create the script to create the Psoxy connection"
}

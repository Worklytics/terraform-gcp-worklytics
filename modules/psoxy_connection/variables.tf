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
  description = "Host of the Worklytics Tenant API"
  default     = "intl.worklytics.co"
}

variable "service_account_email" {
  type        = string
  description = "Email of the GCP service account that has been granted access to the Worklytics Tenant API."
  default     = null

  validation {
    condition     = var.service_account_email == null || can(regex(".*@.*\\.iam\\.gserviceaccount\\.com$", var.service_account_email))
    error_message = "The service_account_email value should be a valid GCP service account email address."
  }
}

variable "psoxy_connection" {
  type = object({
    integration         = string           # The integration ID to use for this connection.
    endpoint            = optional(string) # The endpoint of the Cloud Function (Work Data connections use-case).
    bucket              = optional(string) # The Cloud Storage bucket (Bulk Data connections use-case).
    parser_id           = optional(string) # Bulk Data connections only.
    github_organization = optional(string) # GitHub Connections only.
  })
  description = "The connection details for a Psoxy connection to be created via Worklytics Tenant API."
}

variable "psoxy_connection_script_path" {
  type        = string
  description = "Where to create the script to create the Psoxy connection"
}

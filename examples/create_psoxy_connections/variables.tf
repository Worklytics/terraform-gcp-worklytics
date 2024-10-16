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
    integration = string
    kind        = string
    endpoint    = string
  }))
  description = "The connection details for Psoxy connections to be created via Worklytics Tenant API."
}

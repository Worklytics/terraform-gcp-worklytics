variable "service_account_id" {
  type        = string
  description = "Account ID used to generate the SA email address, 6-30 characters long."
  default     = "worklytics-tenant-api"
}

variable "project_id" {
  type        = string
  description = "ID of the GCP project where you want to create the service account."
}
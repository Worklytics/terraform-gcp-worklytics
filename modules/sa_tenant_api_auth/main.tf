terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.28.0"
    }
  }
}

provider "google" {
  project = var.project_id
}

resource "google_service_account" "worklytics_tenant_api_sa" {
  account_id   = var.service_account_id
  display_name = "Worklytics Tenant API"
}

# get the principal that is going to impersonate the SA (user account use-case)
data "external" "gcloud_email" {
  program = ["bash", "-c", <<-EOT
    email=$(gcloud config get-value account)
    echo "{\"email\": \"$email\"}"
  EOT
  ]
}

# grant the user the roles to impersonate the SA
resource "google_project_iam_member" "user_service_account_user" {
  project = var.project_id
  role    = "roles/iam.serviceAccountUser"
  member  = "user:${data.external.gcloud_email.result.email}"
}

resource "google_project_iam_member" "service_account_token_creator" {
  project = var.project_id
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "user:${data.external.gcloud_email.result.email}"
}

module "service_accounts" {
  source        = "terraform-google-modules/service-accounts/google"
  version       = "4.2.1"
  project_id    = var.project
  names         = [local.serviceaccount_name]
  descriptions  = ["Truefoundry platform user with access to artifact registry, blob storage and secrets manager"]
  display_name  = "Terraform-managed truefoundry platform service account"
  generate_keys = true
  project_roles = local.serviceaccount_roles
}

resource "google_project_iam_member" "secret_manager_role_binding" {
  count = var.feature_secrets_enabled ? 1 : 0

  project = var.project
  role    = "roles/secretmanager.admin"
  member  = module.service_accounts.iam_email

  condition {
    title       = "Restrict to tfy secrets"
    description = "Allows access to secrets that start with 'tfy'"
    expression  = "resource.name.startsWith('projects/${data.google_project.project.number}/secrets/tfy')"
  }
}

resource "google_project_iam_member" "gcs_role_binding" {
  count = var.feature_blob_storage_enabled ? 1 : 0

  project = var.project
  role    = "roles/storage.objectAdmin"
  member  = module.service_accounts.iam_email

  condition {
    title       = "Restrict to tfy storage buckets"
    description = "Allows access to buckets that start with 'tfy'"
    expression  = "resource.name.startsWith('tfy')"
  }
}

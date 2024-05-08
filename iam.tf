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

resource "google_project_iam_custom_role" "artifact_registry_tfy_role" {
  count       = var.feature_docker_registry_enabled ? 1 : 0

  role_id     = replace("${local.trufoundry_platform_resources}_artifcaft_registry_tfy_role", "-", "_")
  title       = "Artifact Registry TFY Role"
  description = "Role to manage Artifact Registry repositories starting with tfy"
  permissions = [
    "artifactregistry.repositories.downloadArtifacts",
    "artifactregistry.repositories.uploadArtifacts",
  ]
}

resource "google_project_iam_custom_role" "gcs_tfy_role" {
  count       = var.feature_blob_storage_enabled ? 1 : 0

  role_id     = replace("${local.trufoundry_platform_resources}_gcs_tfy_role", "-", "_")
  title       = "GCS TFY Role"
  description = "Role to manage GCS buckets starting with tfy"
  permissions = [
    "storage.buckets.get",
    "storage.buckets.create",
    "storage.buckets.delete",
    "storage.buckets.update",
  ]
}

resource "google_project_iam_member" "artifact_registry_role_binding" {
  count       = var.feature_docker_registry_enabled ? 1 : 0
  project     = var.project
  role        = google_project_iam_custom_role.artifact_registry_tfy_role[0].name
  member      = module.service_accounts.iam_email

  condition {
    title       = "Restrict to tfy repositories"
    description = "Allows access to repositories that start with 'tfy'"
    expression  = "resource.name.startsWith('projects/${var.project}/locations/-/repositories/tfy')"
  }
}

resource "google_project_iam_member" "secret_manager_role_binding" {
  count       = var.feature_secrets_enabled ? 1 : 0

  project = var.project
  role    = "roles/secretmanager.admin"
  member  = module.service_accounts.iam_email

  condition {
    title       = "Restrict to tfy secrets"
    description = "Allows access to secrets that start with 'tfy'"
    expression  = "resource.name.startsWith('projects/${var.project}/secrets/tfy')"
  }
}

resource "google_project_iam_member" "gcs_role_binding" {
  count       = var.feature_blob_storage_enabled ? 1 : 0

  project     = var.project
  role        = google_project_iam_custom_role.gcs_tfy_role[0].name
  member      = module.service_accounts.iam_email

  condition {
    title       = "Restrict to tfy storage buckets"
    description = "Allows access to buckets that start with 'tfy'"
    expression  = "resource.name.startsWith('projects/${var.project}/buckets/tfy')"
  }
}

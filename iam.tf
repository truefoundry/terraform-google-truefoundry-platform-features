// create service accounts
resource "google_service_account" "service_account" {
  account_id   = local.serviceaccount_name
  project      = var.project
  display_name = "Terraform-managed truefoundry platform service account"
  description = "Truefoundry platform user with access to artifact registry, blob storage and secrets manager"
}

// custom roles for secret manager
resource "google_project_iam_custom_role" "secret_manager_tfy_role" {
  count       = var.feature_secrets_enabled ? 1 : 0

  role_id     = replace("${local.trufoundry_platform_resources}_bucket_secret_manager_tfy_role", "-", "_")
  title       = "Secret Manager TFY Role"
  description = "Role to manage secrets starting with tfy"
  permissions = [
    "secretmanager.secrets.get",
    "secretmanager.secrets.list",
    "secretmanager.secrets.create",
    "secretmanager.secrets.delete",
    "secretmanager.secrets.update",
    "secretmanager.versions.access",
    "resourcemanager.projects.get",
  ]
}

// custom role for GCS
resource "google_project_iam_custom_role" "gcs_tfy_role" {
  count       = var.feature_blob_storage_enabled ? 1 : 0

  role_id     = replace("${local.trufoundry_platform_resources}_bucket_gcs_tfy_role", "-", "_")
  title       = "GCS TFY Role"
  description = "Role to manage GCS buckets starting with tfy"
  permissions = [
    "storage.objects.create",
    "storage.objects.delete",
    "storage.objects.get",
    "storage.objects.list",
    "storage.objects.update",
    "storage.buckets.create",
    "storage.buckets.get",
    "storage.buckets.list",
    "storage.buckets.create",
    "storage.buckets.update",
    "storage.multipartUploads.create",
    "storage.multipartUploads.list",
    "storage.multipartUploads.listParts",
    "storage.multipartUploads.abort",
    "resourcemanager.projects.get"
  ]
}

// add secret manager custom roles to service account with condition
resource "google_project_iam_member" "secret_manager_role_binding" {
  count = var.feature_secrets_enabled ? 1 : 0

  project = var.project
  role    = google_project_iam_custom_role.secret_manager_tfy_role[count.index].id
  member  = "serviceAccount:${google_service_account.service_account.email}"

  condition {
    title       = "Restrict to tfy secrets"
    description = "Allows access to secrets that start with 'tfy'"
    expression  = "resource.name.startsWith('projects/${data.google_project.project.number}/secrets/tfy')"
  }
}

// add GCS custom roles to service account with condition
resource "google_project_iam_member" "gcs_role_binding" {
  count = var.feature_blob_storage_enabled ? 1 : 0

  project = var.project
  role    = google_project_iam_custom_role.gcs_tfy_role[count.index].id
  member  = "serviceAccount:${google_service_account.service_account.email}"

  condition {
    title       = "Restrict to tfy storage buckets"
    description = "Allows access to buckets that start with 'tfy'"
    expression  = "resource.name.startsWith('projects/_/buckets/tfy')"
  }
}

// add service account to token creator role
resource "google_project_iam_member" "token_creator_role_binding" {
  count = var.feature_blob_storage_enabled ? 1 : 0

  project = var.project
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:${google_service_account.service_account.email}"
}

// add artifact registry role to service account
resource "google_project_iam_member" "artifact_registry_role_binding" {
  count = var.feature_docker_registry_enabled ? 1 : 0

  project = var.project
  role    = "roles/artifactregistry.admin"
  member  = "serviceAccount:${google_service_account.service_account.email}"
}

// add container cluster viewer role to service account
resource "google_project_iam_member" "container_cluster_viewer_role_binding" {
  count = var.feature_cloud_integration_enabled ? 1 : 0

  project = var.project
  role    = "roles/container.clusterViewer"
  member  = "serviceAccount:${google_service_account.service_account.email}"
}

// add container viewer role to service account
resource "google_project_iam_member" "container_viewer_role_binding" {
  count = var.feature_cloud_integration_enabled ? 1 : 0

  project = var.project
  role    = "roles/container.viewer"
  member  = "serviceAccount:${google_service_account.service_account.email}"
}

// service account key
resource "google_service_account_key" "service_account_key" {
  service_account_id = google_service_account.service_account.id
}

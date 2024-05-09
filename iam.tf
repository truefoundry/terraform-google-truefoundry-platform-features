// service account for truefoundry platform feature
resource "google_service_account" "truefoundry_platform_feature_service_account" {
  account_id   = local.serviceaccount_name
  project      = var.project
  display_name = "Terraform-managed truefoundry platform service account"
  description  = "Truefoundry platform user with access to artifact registry, blob storage and secrets manager"
}

// custom role for secret manager
resource "google_project_iam_custom_role" "truefoundry_platform_feature_secret_manager_role" {
  count = var.feature_secrets_enabled ? 1 : 0

  role_id     = replace("${local.trufoundry_platform_resources}_bucket_secret_manager_tfy_role", "-", "_")
  title       = replace("${local.trufoundry_platform_resources}_bucket_secret_manager_tfy_role", "-", "_")
  description = "TrueFoundry platform feature role to manage secrets in GSM"
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
resource "google_project_iam_custom_role" "truefoundry_platform_feature_gcs_bucket_role" {
  count = var.feature_blob_storage_enabled ? 1 : 0

  role_id     = replace("${local.trufoundry_platform_resources}_bucket_gcs_tfy_role", "-", "_")
  title       = replace("${local.trufoundry_platform_resources}_bucket_gcs_tfy_role", "-", "_")
  description = "TrueFoundry platform feature role to manage GCS bucket"
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

// custom role binding with condition for secret manager role
resource "google_project_iam_member" "truefoundry_platform_feature_secret_manager_role_binding" {
  count = var.feature_secrets_enabled ? 1 : 0

  project = var.project
  role    = google_project_iam_custom_role.truefoundry_platform_feature_secret_manager_role[count.index].id
  member  = "serviceAccount:${google_service_account.truefoundry_platform_feature_service_account.email}"

  condition {
    title       = "Condition to allow access to secrets starting with 'tfy'"
    description = "TrueFoundry platform feature role to allows access to secrets that start with 'tfy'"
    expression  = "resource.name.startsWith('projects/${data.google_project.truefoundry_platform_feature_project.number}/secrets/tfy')"
  }
}

// custom role binding with condition for GCS role
resource "google_project_iam_member" "truefoundry_platform_feature_gcs_role_binding" {
  count = var.feature_blob_storage_enabled ? 1 : 0

  project = var.project
  role    = google_project_iam_custom_role.truefoundry_platform_feature_gcs_bucket_role[count.index].id
  member  = "serviceAccount:${google_service_account.truefoundry_platform_feature_service_account.email}"

  condition {
    title       = "Condition to allow access to truefoundry bucket"
    description = "TrueFoundry platform feature role to allows access to buckets that start with 'tfy'"
    expression  = "resource.name.startsWith('projects/_/buckets/${module.blob_storage[0].name}')"
  }
}

// role binding token creator role to service account
resource "google_project_iam_member" "truefoundry_platform_feature_token_creator_role_binding" {
  count = var.feature_blob_storage_enabled ? 1 : 0

  project = var.project
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:${google_service_account.truefoundry_platform_feature_service_account.email}"
}

// role binding artifact registry role to service account
resource "google_project_iam_member" "truefoundry_platform_feature_artifact_registry_role_binding" {
  count = var.feature_docker_registry_enabled ? 1 : 0

  project = var.project
  role    = "roles/artifactregistry.admin"
  member  = "serviceAccount:${google_service_account.truefoundry_platform_feature_service_account.email}"
}

// role binding container cluster viewer role to service account
resource "google_project_iam_member" "truefoundry_platform_feature_container_cluster_viewer_role_binding" {
  count = var.feature_cloud_integration_enabled ? 1 : 0

  project = var.project
  role    = "roles/container.clusterViewer"
  member  = "serviceAccount:${google_service_account.truefoundry_platform_feature_service_account.email}"
}

// role binding container viewer role to service account
resource "google_project_iam_member" "truefoundry_platform_feature_container_viewer_role_binding" {
  count = var.feature_cloud_integration_enabled ? 1 : 0

  project = var.project
  role    = "roles/container.viewer"
  member  = "serviceAccount:${google_service_account.truefoundry_platform_feature_service_account.email}"
}

// service account key
resource "google_service_account_key" "truefoundry_platform_feature_service_account_key" {
  service_account_id = google_service_account.truefoundry_platform_feature_service_account.id
}

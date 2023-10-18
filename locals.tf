locals {
  tags = merge({
    "terraform-module" = "truefoundry-google-platform-features"
    "terraform"        = "true"
    "cluster-name"     = var.cluster_name
    },
    var.tags
  )
  trufoundry_platform_resources = "${var.cluster_name}-platform"
  truefoundry_blob_storage_name = var.blob_storage_enable_override ? var.blob_storage_override_name : "${local.trufoundry_platform_resources}-bucket"
  serviceaccount_name           = trimsuffix(substr("${local.trufoundry_platform_resources}-user", 0, 30), "-")
  serviceaccount_roles = concat(
    var.feature_docker_registry_enabled ? ["${var.project}=>roles/artifactregistry.admin"] : [],
    var.feature_secrets_enabled ? ["${var.project}=>roles/secretmanager.admin"] : [],
    var.feature_blob_storage_enabled ? ["${var.project}=>roles/iam.serviceAccountTokenCreator"] : [],
    var.feature_blob_storage_enabled ? ["${var.project}=>roles/storage.admin"] : []
  )
}
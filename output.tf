################################################################################
# IAM serviceaccount
################################################################################
output "sa_auth_data" {
  value       = base64decode(google_service_account_key.truefoundry_platform_feature_service_account_key.private_key)
  sensitive   = true
  description = "Private key of the service account"
}

################################################################################
# Bucket
################################################################################
output "blob_storage_enabled" {
  value       = var.feature_blob_storage_enabled
  description = "Blob storage feature enabled"
}

output "bucket_name" {
  value       = var.feature_blob_storage_enabled ? module.blob_storage[0].name : ""
  description = "Name of the bucket"
}

output "bucket_url" {
  value       = var.feature_blob_storage_enabled ? module.blob_storage[0].url : ""
  description = "URL of the bucket"
}

################################################################################
# Docker registry (artifact registry)
################################################################################
output "docker_registry_enabled" {
  value       = var.feature_docker_registry_enabled
  description = "Docker registry feature enabled"
}

output "artifact_registry_url" {
  value       = var.feature_docker_registry_enabled ? "${var.region}-docker.pkg.dev/${var.project}" : ""
  description = "Artifact registry URL to connect"
}

################################################################################
# IAM serviceaccount
################################################################################
output "serviceaccount_name" {
  value       = local.serviceaccount_name
  description = "Name of the service account"
}
output "serviceaccount_key" {
  value       = base64decode(google_service_account_key.truefoundry_platform_feature_service_account_key.private_key)
  sensitive   = true
  description = "Service account keys"
}

################################################################################
# Secret manager
################################################################################
output "secret_manger_enabled" {
  value       = var.feature_secrets_enabled
  description = "Secret manager feature enabled"
}

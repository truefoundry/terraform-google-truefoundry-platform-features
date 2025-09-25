################################################################################
# IAM serviceaccount
################################################################################
output "sa_auth_data" {
  value       = var.service_account_enabled && var.service_account_key_creation_enabled ? base64decode(google_service_account_key.truefoundry_platform_feature_service_account_key[0].private_key) : ""
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
output "serviceaccount_enabled" {
  value       = var.service_account_enabled
  description = "Service account feature enabled"
}

output "serviceaccount_key_creation_enabled" {
  value       = var.service_account_key_creation_enabled
  description = "Service account key creation feature enabled"
}

output "serviceaccount_name" {
  value       = var.service_account_enabled && var.service_account_enable_override ? var.service_account_override_name : local.serviceaccount_name
  description = "Name of the service account"
}
output "serviceaccount_key" {
  value       = var.service_account_enabled && var.service_account_key_creation_enabled ? base64decode(google_service_account_key.truefoundry_platform_feature_service_account_key[0].private_key) : ""
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

################################################################################
# Cluster integration
################################################################################
output "cluster_integration_enabled" {
  value       = var.feature_cluster_integration_enabled
  description = "Cluster integration feature enabled"
}

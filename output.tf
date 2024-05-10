################################################################################
# Buket
################################################################################
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
  value       = google_service_account_key.truefoundry_platform_feature_service_account_key.private_key
  sensitive   = true
  description = "Service account keys"
}


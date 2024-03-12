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
  value       = module.service_accounts.service_accounts_map
  description = "Name of the service account"
}
output "serviceaccount_keys" {
  value       = module.service_accounts.keys
  sensitive   = true
  description = "Service account keys"
}

output "serviceaccount_roles" {
  value       = local.serviceaccount_roles
  description = "Roles assigned to the TrueFoundry paltform GCP service account"
}
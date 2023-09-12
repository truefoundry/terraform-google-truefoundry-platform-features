################################################################################
# Buket
################################################################################

output "bucket" {
  value = var.feature_blob_storage_enabled ? module.blob_storage[0].bucket : ""
}
output "bucket_name" {
  value = var.feature_blob_storage_enabled ? module.blob_storage[0].name : ""
}
output "bucket_url" {
  value = var.feature_blob_storage_enabled ? module.blob_storage[0].url : ""
}
################################################################################
# IAM serviceaccount
################################################################################

output "serviceaccount_name" {
  value = module.service_accounts.service_accounts_map
}
output "serviceaccount_keys" {
  value     = module.service_accounts.keys
  sensitive = true
}

output "serviceaccount_roles" {
  value = local.serviceaccount_roles

}
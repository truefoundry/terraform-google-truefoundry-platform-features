module "blob_storage" {
  count                    = var.feature_blob_storage_enabled ? 1 : 0
  source                   = "terraform-google-modules/cloud-storage/google//modules/simple_bucket"
  version                  = "4.0.1"
  project_id               = var.project
  name                     = local.truefoundry_blob_storage_name
  location                 = var.region
  force_destroy            = var.blob_storage_force_destroy
  labels                   = local.tags
  public_access_prevention = "enforced"
  cors = [{
    origin          = var.blob_storage_cors_origins
    method          = ["GET", "POST", "PUT"]
    max_age_seconds = 3000
  }]
  lifecycle_rules = [
    {
      action = {
        type = "AbortIncompleteMultipartUpload"
      }
      condition = {
        age = "7"
      }
    }
  ]
}

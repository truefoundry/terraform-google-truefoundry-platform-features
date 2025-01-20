locals {
  tags = merge({
    "terraform-module" = "truefoundry-google-platform-features"
    "terraform"        = "true"
    "cluster-name"     = var.cluster_name
    "truefoundry"      = "managed"
    },
    var.tags
  )
  truefoundry_platform_resources = "${var.cluster_name}-platform-${random_string.random_id.result}"
  truefoundry_blob_storage_name = var.blob_storage_enable_override ? var.blob_storage_override_name : "${local.truefoundry_platform_resources}-bucket"
  serviceaccount_name           = trimsuffix(substr("${local.truefoundry_platform_resources}-user", 0, 30), "-")
}

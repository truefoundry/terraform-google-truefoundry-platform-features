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
  truefoundry_blob_storage_name  = var.blob_storage_enable_override ? var.blob_storage_override_name : "${local.truefoundry_platform_resources}-bucket"
  serviceaccount_name            = trimsuffix(substr("${local.truefoundry_platform_resources}-user", 0, 30), "-")
  serviceaccount_email           = var.service_account_enabled ? google_service_account.truefoundry_platform_feature_service_account[0].email : var.existing_service_account_email != "" ? var.existing_service_account_email : ""
  serviceaccount_adc_config = var.service_account_enabled && var.service_account_keyless_enabled ? jsonencode({
    universe_domain    = "googleapis.com"
    type               = "external_account"
    audience           = "//iam.googleapis.com/${google_iam_workload_identity_pool_provider.truefoundry_platform_feature_oidc_provider[0].name}"
    subject_token_type = "urn:ietf:params:oauth:token-type:jwt"
    token_url          = "https://sts.googleapis.com/v1/token"
    credential_source = {
      file = "/token"
      format = {
        type = "text"
      }
    }
    service_account_impersonation_url = "https://iamcredentials.googleapis.com/v1/projects/-/serviceAccounts/${local.serviceaccount_email}:generateAccessToken"
  }) : ""
  service_account_iam_binding_principal = var.service_account_keyless_k8s_serviceaccount_name == "*" ? "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.truefoundry_platform_feature_pool[0].name}/attribute.namespace/${var.service_account_keyless_k8s_serviceaccount_namespace}" : "principal://iam.googleapis.com/${google_iam_workload_identity_pool.truefoundry_platform_feature_pool[0].name}/subject/system:serviceaccount:${var.service_account_keyless_k8s_serviceaccount_namespace}:${var.service_account_keyless_k8s_serviceaccount_name}"
}

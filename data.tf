data "google_project" "truefoundry_platform_feature_project" {
  project_id = var.project
}

data "google_service_account" "truefoundry_platform_feature_service_account" {
  count      = var.service_account_enabled ? 0 : 1
  account_id = var.existing_service_account_email
  project    = var.existing_service_account_project != "" ? var.existing_service_account_project : var.project
}
module "service_accounts" {
  source        = "terraform-google-modules/service-accounts/google"
  version       = "4.2.1"
  project_id    = var.project
  names         = [local.serviceaccount_name]
  descriptions  = ["Truefoundry platform user with access to artifact registry, blob storage and secrets manager"]
  display_name  = "Terraform-managed truefoundry platform service account"
  generate_keys = true
  project_roles = local.serviceaccount_roles
}
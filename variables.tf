# From https://github.com/terraform-aws-modules/terraform-aws-eks/blob/master/variables.tf

################################################################################
# Cluster
################################################################################

variable "cluster_name" {
  description = "Name of the cluster"
  type        = string
}

################################################################################
# Generic
################################################################################

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "region" {
  description = "region"
  type        = string
}

variable "project" {
  description = "GCP Project"
  type        = string
}

################################################################################
# Service Account
################################################################################

variable "service_account_enabled" {
  description = "Enable service account feature in the platform"
  type        = bool
  default     = true
}

variable "service_account_key_creation_enabled" {
  description = "Enable service account key creation"
  type        = bool
  default     = true
}

variable "existing_service_account_email" {
  description = "Use existing service account email. If service_account_enabled is false, this variable is required. IMPORTANT: This will override the IAM bindings for the serviceaccount passed in existing_service_account_email. To avoid this, please set service_account_iam_binding_enabled to false."
  type        = string
  default     = ""

  validation {
    condition     = var.service_account_enabled || var.existing_service_account_email != ""
    error_message = "existing_service_account_email is empty when service_account_enabled is false. Please pass the existing service account email."
  }
}

variable "existing_service_account_project" {
  description = "GCP project of the existing service account. Required when existing_service_account_email belongs to a different project than var.project."
  type        = string
  default     = ""
}

variable "service_account_iam_binding_enabled" {
  description = "Enable service account IAM binding. If service_account_enabled is false, this variable will override the IAM bindings for the serviceaccount passed in existing_service_account_email."
  type        = bool
  default     = true
}

variable "service_account_enable_override" {
  description = "Enable overriding name of service account. This will only be used if service_account_enabled is enabled. You need to pass service_account_override_name to pass the service account name"
  type        = bool
  default     = false
}

variable "service_account_override_name" {
  description = "Service account name. Only used if service_account_enable_override is enabled"
  type        = string
  default     = ""
}

variable "service_account_additional_roles" {
  description = "List of additional IAM roles to be added to the service account"
  type        = list(string)
  default     = []
}

variable "service_account_keyless_enabled" {
  description = "Enable keyless authentication using GCP Workload Identity Federation with OIDC. When enabled, an ADC credential config JSON is output via serviceaccount_adc_config. Can be enabled alongside service account key creation during migration"
  type        = bool
  default     = false
}

variable "service_account_keyless_oidc_issuer_url" {
  description = "OIDC issuer URL of the Kubernetes cluster (e.g. https://oidc.eks.us-east-1.amazonaws.com/id/XXXX). Required when service_account_keyless_enabled is true"
  type        = string
  default     = ""
}

variable "service_account_keyless_k8s_serviceaccount_namespace" {
  description = "Kubernetes namespace of the service account that will impersonate the GCP service account. Required when service_account_keyless_enabled is true"
  type        = string
  default     = "truefoundry"
}

variable "service_account_keyless_k8s_serviceaccount_name" {
  description = "Kubernetes service account name that will impersonate the GCP service account. Required when service_account_keyless_enabled is true"
  type        = string
  default     = "truefoundry"
}

################################################################################
## Flyte Propeller
################################################################################
variable "flyte_propeller_serviceaccount_namespace" {
  description = "Namespace for the Flyte Propeller service account"
  type        = string
  default     = "tfy-workflow-propeller"
}

variable "flyte_propeller_serviceaccount_name" {
  description = "Name for the Flyte Propeller service account"
  type        = string
  default     = "flytepropeller"
}

################################################################################
# Blob Storage
################################################################################

variable "feature_blob_storage_enabled" {
  description = "Enable blob storage feature in the platform"
  type        = bool
  default     = true
}

variable "blob_storage_enable_override" {
  description = "Enable overriding name of s3 bucket. This will only be used if feature_blob_storage_enabled is enabled. You need to pass s3_override_name to pass the bucket name"
  type        = bool
  default     = false
}

variable "blob_storage_override_name" {
  description = "S3 bucket name. Only used if s3_enable_override is enabled"
  type        = string
  default     = ""
}

variable "blob_storage_cors_origins" {
  description = "List of CORS origins for Mlfoundry bucket"
  type        = list(string)
  default     = ["*"]
}

variable "blob_storage_force_destroy" {
  description = "Force destroy for mlfoundry s3 bucket"
  default     = true
  type        = bool
}

################################################################################
# GSM
################################################################################
variable "feature_secrets_enabled" {
  description = "Enable secrets manager feature in the platform"
  type        = bool
  default     = true
}

################################################################################
# Artifact registry
################################################################################
variable "feature_docker_registry_enabled" {
  description = "Enable docker registry feature in the platform"
  type        = bool
  default     = true
}

################################################################################
# Cluster integration
################################################################################
variable "feature_cluster_integration_enabled" {
  description = "Enable cluster integration feature in the platform"
  type        = bool
  default     = true
}

################################################################################
# Logging
################################################################################
variable "feature_logs_viewer_enabled" {
  description = "Enable logs viewer permission in the platform"
  type        = bool
  default     = true
}
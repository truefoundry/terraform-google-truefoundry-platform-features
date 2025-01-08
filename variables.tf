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
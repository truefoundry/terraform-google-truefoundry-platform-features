# terraform-google-truefoundry-platform-features
Truefoundry Google Cloud platform features module

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.4 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 6.11 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | ~> 6.11 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_blob_storage"></a> [blob\_storage](#module\_blob\_storage) | terraform-google-modules/cloud-storage/google//modules/simple_bucket | 8.0.1 |

## Resources

| Name | Type |
|------|------|
| [google_project_iam_custom_role.truefoundry_platform_feature_artifact_registry_role](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_custom_role) | resource |
| [google_project_iam_custom_role.truefoundry_platform_feature_cluster_integration_role](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_custom_role) | resource |
| [google_project_iam_custom_role.truefoundry_platform_feature_gcs_bucket_role](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_custom_role) | resource |
| [google_project_iam_custom_role.truefoundry_platform_feature_secret_manager_role](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_custom_role) | resource |
| [google_project_iam_member.truefoundry_platform_feature_artifact_registry_role_binding](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.truefoundry_platform_feature_cluster_integration_role_binding](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.truefoundry_platform_feature_gcs_role_binding](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.truefoundry_platform_feature_secret_manager_role_binding](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.truefoundry_platform_feature_token_creator_role_binding](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_service_account.truefoundry_platform_feature_service_account](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account_key.truefoundry_platform_feature_service_account_key](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_key) | resource |
| [google_project.truefoundry_platform_feature_project](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_blob_storage_cors_origins"></a> [blob\_storage\_cors\_origins](#input\_blob\_storage\_cors\_origins) | List of CORS origins for Mlfoundry bucket | `list(string)` | <pre>[<br/>  "*"<br/>]</pre> | no |
| <a name="input_blob_storage_enable_override"></a> [blob\_storage\_enable\_override](#input\_blob\_storage\_enable\_override) | Enable overriding name of s3 bucket. This will only be used if feature\_blob\_storage\_enabled is enabled. You need to pass s3\_override\_name to pass the bucket name | `bool` | `false` | no |
| <a name="input_blob_storage_force_destroy"></a> [blob\_storage\_force\_destroy](#input\_blob\_storage\_force\_destroy) | Force destroy for mlfoundry s3 bucket | `bool` | `true` | no |
| <a name="input_blob_storage_override_name"></a> [blob\_storage\_override\_name](#input\_blob\_storage\_override\_name) | S3 bucket name. Only used if s3\_enable\_override is enabled | `string` | `""` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the cluster | `string` | n/a | yes |
| <a name="input_feature_blob_storage_enabled"></a> [feature\_blob\_storage\_enabled](#input\_feature\_blob\_storage\_enabled) | Enable blob storage feature in the platform | `bool` | `true` | no |
| <a name="input_feature_cluster_integration_enabled"></a> [feature\_cluster\_integration\_enabled](#input\_feature\_cluster\_integration\_enabled) | Enable cluster integration feature in the platform | `bool` | `true` | no |
| <a name="input_feature_docker_registry_enabled"></a> [feature\_docker\_registry\_enabled](#input\_feature\_docker\_registry\_enabled) | Enable docker registry feature in the platform | `bool` | `true` | no |
| <a name="input_feature_secrets_enabled"></a> [feature\_secrets\_enabled](#input\_feature\_secrets\_enabled) | Enable secrets manager feature in the platform | `bool` | `true` | no |
| <a name="input_project"></a> [project](#input\_project) | GCP Project | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | region | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_artifact_registry_url"></a> [artifact\_registry\_url](#output\_artifact\_registry\_url) | Artifact registry URL to connect |
| <a name="output_blob_storage_enabled"></a> [blob\_storage\_enabled](#output\_blob\_storage\_enabled) | Blob storage feature enabled |
| <a name="output_bucket_name"></a> [bucket\_name](#output\_bucket\_name) | Name of the bucket |
| <a name="output_bucket_url"></a> [bucket\_url](#output\_bucket\_url) | URL of the bucket |
| <a name="output_cluster_integration_enabled"></a> [cluster\_integration\_enabled](#output\_cluster\_integration\_enabled) | Cluster integration feature enabled |
| <a name="output_docker_registry_enabled"></a> [docker\_registry\_enabled](#output\_docker\_registry\_enabled) | Docker registry feature enabled |
| <a name="output_sa_auth_data"></a> [sa\_auth\_data](#output\_sa\_auth\_data) | Private key of the service account |
| <a name="output_secret_manger_enabled"></a> [secret\_manger\_enabled](#output\_secret\_manger\_enabled) | Secret manager feature enabled |
| <a name="output_serviceaccount_key"></a> [serviceaccount\_key](#output\_serviceaccount\_key) | Service account keys |
| <a name="output_serviceaccount_name"></a> [serviceaccount\_name](#output\_serviceaccount\_name) | Name of the service account |
<!-- END_TF_DOCS -->

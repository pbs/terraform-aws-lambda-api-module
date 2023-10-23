# PBS TF Lambda API Module

## Installation

### Using the Repo Source

Use this URL for the source of the module. See the usage examples below for more details.

```hcl
github.com/pbs/terraform-aws-lambda-api-module?ref=x.y.z
```

### Alternative Installation Methods

More information can be found on these install methods and more in [the documentation here](./docs/general/install).

## Usage

This module provisions a Lambda function with an API Gateway in front of it to accept HTTP traffic.

Integrate this module like so:

```hcl
module "api" {
  source = "github.com/pbs/terraform-aws-lambda-api-module?ref=x.y.z"

  handler  = "main"
  filename = "../artifacts/handler.zip"
  runtime  = "go1.x"

  primary_hosted_zone = "example.com"

  # Tagging Parameters
  organization = var.organization
  environment  = var.environment
  product      = var.product
  repo         = var.repo

  # Optional Parameters
}
```

## Adding This Version of the Module

If this repo is added as a subtree, then the version of the module should be close to the version shown here:

`x.y.z`

Note, however that subtrees can be altered as desired within repositories.

Further documentation on usage can be found [here](./docs).

Below is automatically generated documentation on this Terraform module using [terraform-docs][terraform-docs]

---

[terraform-docs]: https://github.com/terraform-docs/terraform-docs

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.22.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_lambda"></a> [lambda](#module\_lambda) | github.com/pbs/terraform-aws-lambda-module | 1.3.32 |

## Resources

| Name | Type |
|------|------|
| [aws_apigatewayv2_api.api](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_api) | resource |
| [aws_apigatewayv2_api_mapping.alternate_domain_api_mapping](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_api_mapping) | resource |
| [aws_apigatewayv2_api_mapping.api_mapping](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_api_mapping) | resource |
| [aws_apigatewayv2_domain_name.alternate_domain_name](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_domain_name) | resource |
| [aws_apigatewayv2_domain_name.domain_name](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_domain_name) | resource |
| [aws_apigatewayv2_integration.integration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_integration) | resource |
| [aws_apigatewayv2_route.route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_route) | resource |
| [aws_apigatewayv2_stage.stage](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_stage) | resource |
| [aws_lambda_permission.lambda_permission](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_route53_record.record](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_acm_certificate.wildcard](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/acm_certificate) | data source |
| [aws_default_tags.common_tags](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/default_tags) | data source |
| [aws_route53_zone.zone](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | Environment (sharedtools, dev, staging, qa, prod) | `string` | n/a | yes |
| <a name="input_organization"></a> [organization](#input\_organization) | Organization using this module. Used to prefix tags so that they are easily identified as being from your organization | `string` | n/a | yes |
| <a name="input_product"></a> [product](#input\_product) | Tag used to group resources according to product | `string` | n/a | yes |
| <a name="input_repo"></a> [repo](#input\_repo) | Tag used to point to the repo using this module | `string` | n/a | yes |
| <a name="input_acm_arn"></a> [acm\_arn](#input\_acm\_arn) | ARN of the ACM certificate for the API integration | `string` | `null` | no |
| <a name="input_add_app_config_extension_layer"></a> [add\_app\_config\_extension\_layer](#input\_add\_app\_config\_extension\_layer) | Add the AWS-AppConfig-Lambda-Extension layer to the Lambda function. Ignored if layers is not null or if runtime is not supported. | `bool` | `true` | no |
| <a name="input_add_ssm_extension_layer"></a> [add\_ssm\_extension\_layer](#input\_add\_ssm\_extension\_layer) | Add the AWS-Parameters-and-Secrets-Lambda-Extension layer to the Lambda function. Ignored if layers is not null or if using the ARM runtime. | `bool` | `true` | no |
| <a name="input_add_vpc_config"></a> [add\_vpc\_config](#input\_add\_vpc\_config) | Add VPC configuration to the Lambda function | `bool` | `false` | no |
| <a name="input_allow_app_config_access"></a> [allow\_app\_config\_access](#input\_allow\_app\_config\_access) | Allow AppConfig access from the Lambda function. Ignored if `policy_json` or `role_arn` are set. | `bool` | `true` | no |
| <a name="input_alternate_domain_name"></a> [alternate\_domain\_name](#input\_alternate\_domain\_name) | Alternate domain name for the API for which a DNS record will not be created. This can be useful for APIs that need to have CNAMEs defined in external accounts. | `string` | `null` | no |
| <a name="input_app_config_extension_account_number"></a> [app\_config\_extension\_account\_number](#input\_app\_config\_extension\_account\_number) | Account number for the AWS-AppConfig-Extension layer | `string` | `"027255383542"` | no |
| <a name="input_app_config_extension_version"></a> [app\_config\_extension\_version](#input\_app\_config\_extension\_version) | Lambda layer version for the AWS-AppConfig-Extension layer | `number` | `null` | no |
| <a name="input_architectures"></a> [architectures](#input\_architectures) | Architectures to target for the Lambda function | `list(string)` | <pre>[<br>  "x86_64"<br>]</pre> | no |
| <a name="input_auto_deploy"></a> [auto\_deploy](#input\_auto\_deploy) | Auto deploy API Gateway updates. Leave this true | `string` | `"true"` | no |
| <a name="input_connection_type"></a> [connection\_type](#input\_connection\_type) | Connection type for the integeration endpoint. Probably want this to be INTERNET | `string` | `"INTERNET"` | no |
| <a name="input_cors_configuration"></a> [cors\_configuration](#input\_cors\_configuration) | CORS configuration map | `any` | `null` | no |
| <a name="input_create_dns"></a> [create\_dns](#input\_create\_dns) | Whether or not to provision a CNAME pointing to this API. domain\_name returns API integration target, which requires separate CNAME if false. | `bool` | `true` | no |
| <a name="input_disable_execute_api_endpoint"></a> [disable\_execute\_api\_endpoint](#input\_disable\_execute\_api\_endpoint) | (optional) disable default execute endpoint | `bool` | `true` | no |
| <a name="input_dns_evaluate_target_health"></a> [dns\_evaluate\_target\_health](#input\_dns\_evaluate\_target\_health) | (optional) evaluate health of endpoints by querying DNS records | `bool` | `false` | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | Domain name for the API | `string` | `null` | no |
| <a name="input_endpoint_type"></a> [endpoint\_type](#input\_endpoint\_type) | Endpoint type. Leave this REGIONAL | `string` | `"REGIONAL"` | no |
| <a name="input_environment_vars"></a> [environment\_vars](#input\_environment\_vars) | Map of environment variables for the Lambda. If null, defaults to setting an SSM\_PATH based on the environment and name of the function. Set to {} if you would like for there to be no environment variables present. This is important if you are creating a Lambda@Edge. | `map(any)` | `null` | no |
| <a name="input_file_system_config"></a> [file\_system\_config](#input\_file\_system\_config) | File system configuration for the Lambda function | `map(any)` | `null` | no |
| <a name="input_filename"></a> [filename](#input\_filename) | Filename for the artifact to use for the Lambda | `string` | `null` | no |
| <a name="input_handler"></a> [handler](#input\_handler) | Lambda handler | `string` | `null` | no |
| <a name="input_image_uri"></a> [image\_uri](#input\_image\_uri) | URI of the container image to use for the Lambda | `string` | `null` | no |
| <a name="input_integration_description"></a> [integration\_description](#input\_integration\_description) | Integration description. Auto-generated off local.name if null | `string` | `null` | no |
| <a name="input_integration_method"></a> [integration\_method](#input\_integration\_method) | Integration method. Leave this POST | `string` | `"POST"` | no |
| <a name="input_integration_type"></a> [integration\_type](#input\_integration\_type) | Integration type. Leave this AWS\_PROXY | `string` | `"AWS_PROXY"` | no |
| <a name="input_lambda_description"></a> [lambda\_description](#input\_lambda\_description) | Description for this lambda function | `string` | `null` | no |
| <a name="input_lambda_insights_extension_account_number"></a> [lambda\_insights\_extension\_account\_number](#input\_lambda\_insights\_extension\_account\_number) | Account number for the LambdaInsightsExtension layer | `string` | `"580247275435"` | no |
| <a name="input_lambda_insights_extension_version"></a> [lambda\_insights\_extension\_version](#input\_lambda\_insights\_extension\_version) | Lambda layer version for the LambdaInsightsExtension layer | `number` | `null` | no |
| <a name="input_lambda_name"></a> [lambda\_name](#input\_lambda\_name) | Name of the Lambda function | `string` | `null` | no |
| <a name="input_layers"></a> [layers](#input\_layers) | Lambda layers to apply to function. If null, a Lambda Layer extension is added by default. | `list(string)` | `null` | no |
| <a name="input_log_retention_in_days"></a> [log\_retention\_in\_days](#input\_log\_retention\_in\_days) | Number of days to retain CloudWatch Log entries | `number` | `7` | no |
| <a name="input_memory_size"></a> [memory\_size](#input\_memory\_size) | Amount of memory in MB your Lambda Function can use at runtime | `number` | `128` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the API | `string` | `null` | no |
| <a name="input_package_type"></a> [package\_type](#input\_package\_type) | Package type for the Lambda function. Valid values are Zip and Image. | `string` | `"Zip"` | no |
| <a name="input_parameters_and_secrets_extension_account_number"></a> [parameters\_and\_secrets\_extension\_account\_number](#input\_parameters\_and\_secrets\_extension\_account\_number) | Account number for the AWS-Parameters-and-Secrets-Lambda-Extension layer | `string` | `"177933569100"` | no |
| <a name="input_parameters_and_secrets_extension_version"></a> [parameters\_and\_secrets\_extension\_version](#input\_parameters\_and\_secrets\_extension\_version) | Lambda layer version for the AWS-Parameters-and-Secrets-Lambda-Extension layer | `number` | `null` | no |
| <a name="input_payload_format_version"></a> [payload\_format\_version](#input\_payload\_format\_version) | (optional) payload format version | `string` | `"1.0"` | no |
| <a name="input_permissions_boundary_arn"></a> [permissions\_boundary\_arn](#input\_permissions\_boundary\_arn) | ARN of the permissions boundary to use on the role created for this lambda | `string` | `null` | no |
| <a name="input_policy_json"></a> [policy\_json](#input\_policy\_json) | Policy JSON. If null, default policy granting access to SSM and cloudwatch logs is used | `string` | `null` | no |
| <a name="input_primary_hosted_zone"></a> [primary\_hosted\_zone](#input\_primary\_hosted\_zone) | Primary hosted zone for the API. e.g. example.org | `string` | `null` | no |
| <a name="input_protocol_type"></a> [protocol\_type](#input\_protocol\_type) | Protocol type. Can be HTTP and WEBSOCKET | `string` | `"HTTP"` | no |
| <a name="input_publish"></a> [publish](#input\_publish) | Whether to publish creation/change as new Lambda Function Version | `bool` | `true` | no |
| <a name="input_role_arn"></a> [role\_arn](#input\_role\_arn) | ARN of the role to be used for this Lambda | `string` | `null` | no |
| <a name="input_route_key"></a> [route\_key](#input\_route\_key) | Route key. Leave this $default | `string` | `"$default"` | no |
| <a name="input_runtime"></a> [runtime](#input\_runtime) | Runtime for the lambda function | `string` | `null` | no |
| <a name="input_security_group_id"></a> [security\_group\_id](#input\_security\_group\_id) | Security group ID. If null, one will be created. | `string` | `null` | no |
| <a name="input_security_policy"></a> [security\_policy](#input\_security\_policy) | TLS version. Leave this TLS\_1\_2 | `string` | `"TLS_1_2"` | no |
| <a name="input_ssm_path"></a> [ssm\_path](#input\_ssm\_path) | SSM path to use for environment variables. If null, defaults to /${var.environment}/${local.name} | `string` | `null` | no |
| <a name="input_stage_name"></a> [stage\_name](#input\_stage\_name) | Name of the stage | `string` | `"$default"` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | Subnets to use for the Lambda function. Ignored if add\_vpc\_config is false. If null, one will be looked up based on environment tag. | `list(string)` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Extra tags | `map(string)` | `{}` | no |
| <a name="input_throttling_burst_limit"></a> [throttling\_burst\_limit](#input\_throttling\_burst\_limit) | (optional) throttling burst limit | `number` | `5000` | no |
| <a name="input_throttling_rate_limit"></a> [throttling\_rate\_limit](#input\_throttling\_rate\_limit) | (optional) throttling rate limit | `number` | `10000` | no |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | Timeout in seconds of the Lambda | `number` | `3` | no |
| <a name="input_tracing_config_mode"></a> [tracing\_config\_mode](#input\_tracing\_config\_mode) | Tracing config mode for X-Ray integration on Lambda | `string` | `"Active"` | no |
| <a name="input_use_prefix"></a> [use\_prefix](#input\_use\_prefix) | Use prefix for resources instead of explicitly defining whole name where possible | `bool` | `true` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID. If null, one will be looked up based on environment tag. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alternate_domain_endpoint"></a> [alternate\_domain\_endpoint](#output\_alternate\_domain\_endpoint) | Alternate endpoint that the API can be accessed at if a CNAME corresponding to `alternate_domain_name` resolves to this endpoint. Only populated if `alternate_domain_name` is not null |
| <a name="output_alternate_domain_name"></a> [alternate\_domain\_name](#output\_alternate\_domain\_name) | Alternate domain name that the API can be accessed at. Returns the CNAME record name that should be created externally for the API with value output as `alternate_domain_endpoint`. This is useful for APIs where the CNAME is defined in another account. |
| <a name="output_arn"></a> [arn](#output\_arn) | ARN of the API Gateway |
| <a name="output_domain_name"></a> [domain\_name](#output\_domain\_name) | Domain name that the API can be accessed at. If create\_dns, return the CNAME created for the API, otherwise return the api integration domain name. This is useful when creating a DNS record for the API is not desired. |
| <a name="output_lambda_arn"></a> [lambda\_arn](#output\_lambda\_arn) | ARN of the Lambda function |
| <a name="output_lambda_name"></a> [lambda\_name](#output\_lambda\_name) | Name of the Lambda function |
| <a name="output_sg"></a> [sg](#output\_sg) | Security group of the lambda function if there is one |

# acp-tf-aws-alerting-channels
<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | n/a |
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.lambda_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_lambda_function.slack_lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_lambda_permission.lambda_sns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_sns_topic.email](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_sns_topic.opsgenie](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_sns_topic.slack](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_sns_topic_subscription.email](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |
| [aws_sns_topic_subscription.opsgenie](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |
| [aws_sns_topic_subscription.slack](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |
| [archive_file.file](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |
| [aws_iam_policy_document.lambda_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.lambda_kms_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_email_address"></a> [email\_address](#input\_email\_address) | The email address to alert when a cloudwatch alarm is triggered. | `string` | `"test@test.com"` | no |
| <a name="input_lambda_handler"></a> [lambda\_handler](#input\_lambda\_handler) | The method used to execute your function. consists of file name and function name. | `string` | `"slack_alert.lambda_handler"` | no |
| <a name="input_opsgenie_url"></a> [opsgenie\_url](#input\_opsgenie\_url) | The opsgenie url endpoint for the sns topic subscription. | `string` | `""` | no |
| <a name="input_runtime"></a> [runtime](#input\_runtime) | The runtime engine of the lambda function. | `string` | `"python3.8"` | no |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | The service name that the sns topics relate to. | `string` | `""` | no |
| <a name="input_slack_channel"></a> [slack\_channel](#input\_slack\_channel) | The slack channel to set as an environment variable within the lambda function. | `string` | `""` | no |
| <a name="input_slack_url"></a> [slack\_url](#input\_slack\_url) | The slack URL to set as an environment variable within the lambda function. | `string` | `""` | no |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | the lambda functions timeout in seconds | `string` | `"60"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_email_sns_arn"></a> [email\_sns\_arn](#output\_email\_sns\_arn) | n/a |
| <a name="output_opsgenie_sns_arn"></a> [opsgenie\_sns\_arn](#output\_opsgenie\_sns\_arn) | n/a |
| <a name="output_slack_sns_arn"></a> [slack\_sns\_arn](#output\_slack\_sns\_arn) | n/a |
<!-- END_TF_DOCS -->

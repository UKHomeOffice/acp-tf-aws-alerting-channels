locals {
  environment_account_ids_encoded = base64encode(jsonencode(var.environments_account_ids))
}

resource "aws_lambda_function" "slack_lambda" {
  count         = var.slack_required ? 1 : 0
  filename      = data.archive_file.file.output_path
  function_name = "${var.service_name}-lambda-notify-slack"
  role          = aws_iam_role.lambda_role[count.index].arn
  handler       = var.lambda_handler

  source_code_hash = data.archive_file.file.output_base64sha256
  runtime          = var.runtime
  timeout          = var.timeout
  environment {
    variables = {
      kmsEncryptedHookUrl     = var.slack_url
      slackChannel            = var.slack_channel
      ENVIRONMENT_ACCOUNT_IDS = local.environment_account_ids_encoded
    }
  }
  depends_on = [
    data.archive_file.file
  ]
}

resource "aws_lambda_permission" "lambda_sns" {
  count         = var.slack_required ? 1 : 0
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.slack_lambda[count.index].function_name
  principal     = "sns.amazonaws.com"
  source_arn    = aws_sns_topic.slack[count.index].arn
}

data "archive_file" "file" {
  type        = "zip"
  source_file = "${path.module}/slack_alert.py"
  output_path = "${path.module}/lambda_function.zip"
}
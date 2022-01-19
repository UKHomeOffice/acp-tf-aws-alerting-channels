resource "aws_sns_topic" "opsgenie" {
  count = var.opsgenie_required ? 1 : 0
  name  = "${var.service_name}-opsgenie-notification"
}

resource "aws_sns_topic" "slack" {
  count = var.slack_required ? 1 : 0
  name  = "${var.service_name}-slack-notification"
}

resource "aws_sns_topic" "email" {
  count = var.email_required ? 1 : 0
  name  = "${var.service_name}-email-notification"
}

resource "aws_sns_topic_subscription" "opsgenie" {
  count = var.opsgenie_required ? 1 : 0
  topic_arn = aws_sns_topic.opsgenie[count.index].arn
  endpoint = var.opsgenie_url
  protocol = "https"
}

resource "aws_sns_topic_subscription" "slack" {
  count = var.slack_required ? 1 : 0
  topic_arn = aws_sns_topic.slack[count.index].arn
  endpoint = aws_lambda_function.slack_lambda[count.index].arn
  protocol = "lambda"
}

resource "aws_sns_topic_subscription" "email" {
  count = var.email_required ? 1 : 0
  topic_arn = aws_sns_topic.email[count.index].arn
  endpoint = var.email_address
  protocol = "email"
}

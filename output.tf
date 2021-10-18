output "opsgenie_sns_arn" {
    value = aws_sns_topic.opsgenie.arn
}

output "slack_sns_arn" {
    value = aws_sns_topic.slack.arn
}

output "email_sns_arn" {
    value = aws_sns_topic.email.arn
}

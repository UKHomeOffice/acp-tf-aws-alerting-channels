#SNS


variable "service_name" { 
    description = "The service name that the sns topics relate to."
    default = ""
}

variable "email_address" { 
    description = "The email address to alert when a cloudwatch alarm is triggered."
    default = "test@test.com"
}


variable "opsgenie_url" {
    description = "The opsgenie url endpoint for the sns topic subscription."
    default = ""
} 

#Lambda
variable "lambda_handler" { 
    description = "The method used to execute your function. consists of file name and function name."
    default = "slack_alert.lambda_handler"
} 

variable "runtime" { 
    description = "The runtime engine of the lambda function."
    default = "python3.8" 
} 

variable "slack_url" {
    description = "The slack URL to set as an environment variable within the lambda function."
    default = ""
} 
variable "slack_channel" {
    description = "The slack channel to set as an environment variable within the lambda function."
    default = ""
} 

variable "timeout" { 
    description = "the lambda functions timeout in seconds"
    default = "60" 
} 
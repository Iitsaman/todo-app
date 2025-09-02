
variable "alarm_config" {
  type = object({
    alarm_name           = string
    comparison_operator  = string
    evaluation_periods   = number
    metric_name          = string
    namespace            = string
    period               = number
    statistic            = string
    threshold            = number
    alarm_description    = string
   # alarm_actions        = list(string)
    dimensions           = map(string)
  })
}

variable "email_address" {
  description = "Email address for alarm notifications"
  type        = string
}
variable "instance_ids" {
  description = "List of EC2 Instance IDs"
  type        = list(string)
}

variable "sns_topic_name" {
  type        = string
  description = "Name of the SNS topic to create"
}
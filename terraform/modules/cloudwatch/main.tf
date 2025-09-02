# creates an SNS topic
resource "aws_sns_topic" "alarm_topic" {
  name =   var.sns_topic_name           #"${terraform.workspace}-alarms"
}

# subscribe an email to that SNS topic

resource "aws_sns_topic_subscription" "email_alert" {
  topic_arn = aws_sns_topic.alarm_topic.arn
  protocol  = "email"
  endpoint  = var.email_address
}


resource "aws_cloudwatch_metric_alarm" "my_cloudwatch_alarm" {
   count = length(var.instance_ids)
  alarm_name                = var.alarm_config.alarm_name  #"${var.alarm_config.alarm_name}-${count.index}"
  comparison_operator       = var.alarm_config.comparison_operator
  evaluation_periods        = var.alarm_config.evaluation_periods
  metric_name               = var.alarm_config.metric_name
  namespace                 = var.alarm_config.namespace
 # dimensions                = var.alarm_config.dimensions
  threshold                 = var.alarm_config.threshold
  period                    = var.alarm_config.period
  statistic                 = var.alarm_config.statistic
  alarm_description         = var.alarm_config.alarm_description
  treat_missing_data        = "notBreaching"
  dimensions = {
      InstanceId = var.instance_ids[count.index]
    }
  alarm_actions             = [aws_sns_topic.alarm_topic.arn] #var.alarm_config.alarm_actions
}
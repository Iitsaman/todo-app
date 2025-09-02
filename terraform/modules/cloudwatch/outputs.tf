output "alarm_arns" {
  value = [for alarm in aws_cloudwatch_metric_alarm.my_cloudwatch_alarm : alarm.arn]
}


output "sns_topic_arn" {
  value = aws_sns_topic.alarm_topic.arn
}



/*
output "alarm_arn" {
  value = aws_cloudwatch_metric_alarm.my_cloudwatch_alaram.arn
}

output "alarm_id" {
  value = aws_cloudwatch_metric_alarm.my_cloudwatch_alaram.id
}

output "sns_topic_arn" {
  value = aws_sns_topic.alarm_topic.arn
}
*/
#https://www.youtube.com/watch?v=mXQSnbc9jMs

resource "aws_cloudwatch_metric_alarm" "TrainingAlarm" {
  alarm_name                = "TrainingAlarm"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 2
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = 120
  statistic                 = "Average"
  threshold                 = 2
  alarm_description         = "This metric monitors ec2 cpu utilization"
  insufficient_data_actions = []
}
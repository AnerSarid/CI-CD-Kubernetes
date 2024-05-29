resource "aws_cloudwatch_log_group" "eks_log_group" {
  name              = "/aws/eks/main-cluster"
  retention_in_days = 30

  tags = {
    Name = "eks-log-group"
  }
}

resource "aws_cloudwatch_log_stream" "eks_log_stream" {
  name           = "main-log-stream"
  log_group_name = aws_cloudwatch_log_group.eks_log_group.name
}

resource "aws_cloudwatch_metric_alarm" "cpu_utilization" {
  alarm_name          = "high-cpu-utilization"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EKS"
  period              = "300"
  statistic           = "Average"
  threshold           = "70"

  dimensions = {
    ClusterName = "main-cluster"
  }

  alarm_description = "Alarm when CPU utilization exceeds 70%"
  alarm_actions     = [aws_sns_topic.alarms.arn]
}

resource "aws_sns_topic" "alarms" {
  name = "alarms-topic"

  tags = {
    Name = "alarms-topic"
  }
}

resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.alarms.arn
  protocol  = "email"
  endpoint  = "example@example.com"
}

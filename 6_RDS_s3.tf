resource "aws_rds_cluster" "postgresql" {
  cluster_identifier      = "aurora-cluster-demo"
  engine                  = "aurora-postgresql"
  availability_zones      = ["us-east-1a"]
  database_name           = "mydb"
  master_username         = "foo"
  master_password         = "bar123456"
  backup_retention_period = 5
  preferred_backup_window = "07:00-09:00"
  skip_final_snapshot = true
}

# resource "aws_s3_bucket" "TrainingABC081" {
#   bucket        = "tf-test-trail"
#   force_destroy = true
# }

# resource "aws_cloudtrail" "foobar" {
#   name                          = "tf-trail-foobar"
#   s3_bucket_name                = aws_s3_bucket.foo.id
#   s3_key_prefix                 = "prefix"
#   include_global_service_events = false
# }

# data "aws_iam_policy_document" "foo" {
#   statement {
#     sid    = "AWSCloudTrailAclCheck"
#     effect = "Allow"

#     principals {
#       type        = "Service"
#       identifiers = ["cloudtrail.amazonaws.com"]
#     }

#     actions   = ["s3:GetBucketAcl"]
#     resources = [aws_s3_bucket.foo.arn]
#   }

#   statement {
#     sid    = "AWSCloudTrailWrite"
#     effect = "Allow"

#     principals {
#       type        = "Service"
#       identifiers = ["cloudtrail.amazonaws.com"]
#     }

#     actions   = ["s3:PutObject"]
#     resources = ["${aws_s3_bucket.foo.arn}/prefix/AWSLogs/${data.aws_caller_identity.current.account_id}/*"]

#     condition {
#       test     = "StringEquals"
#       variable = "s3:x-amz-acl"
#       values   = ["bucket-owner-full-control"]
#     }
#   }
# }
data "aws_caller_identity" "current" {}

resource "aws_iam_role" "server_role" {
  name = "${var.project}-server-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = "sts:AssumeRole"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_policy" "jenkins_policy" {
  name        = var.jenkins_policy
  description = "Minimum permissions for Jenkins to deploy BaoAfrik apps"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:DescribeInstances",
          "ec2:DescribeTags"
        ]
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_policy" "backend_s3_policy" {
  name        = var.backend_s3_policy
  description = "Allow backend to interact with S3 bucket, generate pre-signed S3 URLs, upload, view and delete objects"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement : [
      {
        Effect = "Allow",
        Action : [
          "s3:PutObject",
          "s3:GetObject",
          "s3:DeleteObject",
          "s3:ListBucket",
        ],
        Resource : [
          "arn:aws:s3:::${var.staging_bucket}",
          "arn:aws:s3:::${var.staging_bucket}/*",
          "arn:aws:s3:::${var.dev_bucket}",
          "arn:aws:s3:::${var.dev_bucket}/*",
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "jenkins_attach" {
  role       = aws_iam_role.server_role.name
  policy_arn = aws_iam_policy.jenkins_policy.arn
}

resource "aws_iam_role_policy_attachment" "backend_s3_attach" {
  role       = aws_iam_role.server_role.name
  policy_arn = aws_iam_policy.backend_s3_policy.arn
}

resource "aws_iam_instance_profile" "server_instance_profile" {
  name = var.server_instance_profile
  role = aws_iam_role.server_role.name
}

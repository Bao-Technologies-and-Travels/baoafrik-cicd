# data "aws_caller_identity" "current" {}

# data "aws_iam_role" "server_role" {
#   name = "${var.project}-server-role"
# }

# data "aws_iam_policy" "jenkins_policy" {
#   name = var.jenkins_policy
# }

# data "aws_iam_policy" "backend_s3_policy" {
#   name = var.backend_s3_policy
# }

# data "aws_iam_instance_profile" "server_instance_profile" {
#   name = var.server_instance_profile
# }
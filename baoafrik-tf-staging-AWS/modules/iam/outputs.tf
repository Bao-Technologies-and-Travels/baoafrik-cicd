output "server_role_arn" {
  value = aws_iam_role.server_role.arn
}

output "server_instance_profile_name" {
  value = aws_iam_instance_profile.server_instance_profile.name
}


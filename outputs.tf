output "idp_arn" {
  value       = aws_iam_saml_provider.this.arn
  description = "ARN of the SAML Identity Provider"
}

output "admin_role_arn" {
  value       = aws_iam_role.admin.arn
  description = "ARN of the administrator access role"
}

output "poweruser_role_arn" {
  value       = aws_iam_role.poweruser.arn
  description = "ARN of the power user access role"
}

output "readonly_role_arn" {
  value       = aws_iam_role.readonly.arn
  description = "ARN of the read-only access role"
}
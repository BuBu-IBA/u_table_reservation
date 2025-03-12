output "user_pool_id" {
  value = aws_cognito_user_pool.user_pool.id
}

output "identity_pool_id" {
  value = aws_cognito_identity_pool.identity_pool.id
}

output "cognito_authorizer_id" {
  value = aws_api_gateway_authorizer.cognito_authorizer.id 
}
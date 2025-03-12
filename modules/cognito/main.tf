resource "aws_cognito_user_pool" "user_pool" {
  name = "table-reservation-user-pool"
}

resource "aws_cognito_user_pool_client" "user_pool_client" {
  name         = "restaurant-app-client"
  user_pool_id = aws_cognito_user_pool.user_pool.id
}

resource "aws_cognito_identity_pool" "identity_pool" {
  identity_pool_name = "table-reservation-identity-pool"
  allow_unauthenticated_identities = false
}

resource "aws_api_gateway_authorizer" "cognito_authorizer" {
    rest_api_id = var.reservation_api_id
    name        = "cognito_authorizer"
    type        = "COGNITO_USER_POOLS"
    provider_arns = [
        aws_cognito_user_pool.user_pool.arn
    ]
}

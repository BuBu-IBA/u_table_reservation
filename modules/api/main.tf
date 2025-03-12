resource "aws_api_gateway_rest_api" "api" {
  name        = "table_reservation_api"
  description = "API to manage restaurant table reservations"
}

resource "aws_api_gateway_resource" "available_tables" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "available_tables"
}

resource "aws_api_gateway_method" "get_available_tables" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.available_tables.id
  http_method   = "GET"
  # authorization = "NONE"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = var.cognito_authorizer_id
}

resource "aws_api_gateway_integration" "get_available_tables_integration" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.available_tables.id
  http_method = aws_api_gateway_method.get_available_tables.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.get_available_tables_invoke_arn
}

resource "aws_api_gateway_resource" "reservation" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "reservation"
}

resource "aws_api_gateway_method" "get_reservation" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.reservation.id
  http_method   = "GET"
  # authorization = "NONE"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = var.cognito_authorizer_id
}

resource "aws_api_gateway_integration" "getreservation_integration" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.reservation.id
  http_method = aws_api_gateway_method.get_reservation.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.get_reservation_invoke_arn
}

resource "aws_api_gateway_resource" "create_reservation" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "create_reservation"
}

resource "aws_api_gateway_method" "post_create_reservation" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.create_reservation.id
  http_method   = "POST"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = var.cognito_authorizer_id
}

resource "aws_api_gateway_integration" "create_reservation_integration" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.create_reservation.id
  http_method = aws_api_gateway_method.post_create_reservation.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.create_reservation_invoke_arn
}
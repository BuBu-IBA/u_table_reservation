output "reservation_api_id" {
  value = aws_api_gateway_rest_api.api.id
}

output "api_execution_arn" {
  value = aws_api_gateway_rest_api.api.execution_arn
}
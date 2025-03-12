output "get_available_tables_invoke_arn" {
  value = aws_lambda_function.get_available_tables.invoke_arn
}

output "get_reservation_invoke_arn" {
  value = aws_lambda_function.get_reservation.invoke_arn
}

output "create_reservation_invoke_arn" {
  value = aws_lambda_function.create_reservation.invoke_arn
}
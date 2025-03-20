resource "aws_lambda_function" "get_available_tables" {
  function_name = "get_available_tables"
  runtime       = "python3.8"
  handler       = "lambda_function.get_available_tables"
  role          = var.lambda_role_arn
  timeout       = 3
  filename      = "path/to/lambda/get_available_tables.zip"

  vpc_config {
    subnet_ids         = [var.private_subnet_id]
    security_group_ids = [aws_security_group.lambda_sg.id]
  }
}

resource "aws_lambda_function" "get_reservation" {
  function_name = "get_reservation"
  runtime       = "python3.8"
  handler       = "lambda_function.get_reservation"
  role          = var.lambda_role_arn
  timeout       = 3
  filename      = "path/to/lambda/get_reservation.zip"

  vpc_config {
    subnet_ids         = [var.private_subnet_id]
    security_group_ids = [aws_security_group.lambda_sg.id]
  }
}

resource "aws_lambda_function" "create_reservation" {
  function_name = "create_reservation"
  runtime       = "python3.8"
  handler       = "lambda_function.create_reservation"
  role          = var.lambda_role_arn
  timeout       = 5
  filename         = "path/to/lambda/create_reservation.zip"

  vpc_config {
    subnet_ids         = [var.private_subnet_id]
    security_group_ids = [aws_security_group.lambda_sg.id]
  }
}

resource "aws_security_group" "lambda_sg" {
  vpc_id = var.vpc_id
}

resource "aws_lambda_permission" "allow_api_gateway_get_available_tables" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${var.api_execution_arn}/*"
  function_name = aws_lambda_function.get_available_tables.function_name
}

resource "aws_lambda_permission" "allow_api_gateway_get_reservation" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${var.api_execution_arn}/*"
  function_name = aws_lambda_function.get_reservation.function_name
}

resource "aws_lambda_permission" "allow_api_gateway_create_reservation" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${var.api_execution_arn}/*"
  function_name = aws_lambda_function.create_reservation.function_name
}

######################
# CloudWatch logs
######################

resource "aws_cloudwatch_log_group" "get_available_tables_log_group" {
  name              = "/aws/lambda/get_available_tables"
  retention_in_days = 14
}
resource "aws_cloudwatch_log_group" "get_reservation_log_group" {
  name              = "/aws/lambda/get_reservation"
  retention_in_days = 14
}
resource "aws_cloudwatch_log_group" "create_reservation_log_group" {
  name              = "/aws/lambda/create_reservation"
  retention_in_days = 14
}
variable "get_available_tables_invoke_arn" {
  description = "The ARN to invoke the get_available_tables Lambda function"
  type        = string
}

variable "get_reservation_invoke_arn" {
  description = "The ARN to invoke the get_reservation Lambda function"
  type        = string
}

variable "create_reservation_invoke_arn" {
  description = "The ARN to invoke the create_reservation Lambda function"
  type        = string
}

variable "cognito_authorizer_id" {
  description = "The ID of the Cognito authorizer"
  type        = string
}
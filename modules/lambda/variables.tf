variable "api_execution_arn" {
  description = "The ARN of the API Gateway REST API execution"
  type        = string
}

variable "private_subnet_id" {
  description = "The ID of the private subnet"
  type        = string
}

variable "lambda_role_arn" {
  description = "The ARN of the IAM role for the Lambda function"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC endpoint"
  type        = string
}
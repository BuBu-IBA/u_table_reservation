module "vpc" {
  source = "./modules/vpc"
}

module "s3" {
  source = "./modules/s3"
}

module "shield" {
  source           = "./modules/shield"
  distribution_arn = module.cloudfront.distribution_arn
}

module "cloudfront" {
  source                      = "./modules/cloudfront"
  bucket_name                 = module.s3.bucket_name
  bucket_regional_domain_name = module.s3.bucket_regional_domain_name
}

module "dynamodb" {
  source = "./modules/dynamodb"
}

module "cognito" {
  source             = "./modules/cognito"
  reservation_api_id = module.api.reservation_api_id
}

module "api" {
  source                          = "./modules/api"
  get_available_tables_invoke_arn = module.lambda.get_available_tables_invoke_arn
  get_reservation_invoke_arn      = module.lambda.get_reservation_invoke_arn
  create_reservation_invoke_arn   = module.lambda.create_reservation_invoke_arn
  cognito_authorizer_id           = module.cognito.cognito_authorizer_id
}

module "lambda" {
  source            = "./modules/lambda"
  vpc_id            = module.vpc.vpc_id
  private_subnet_id = module.vpc.private_subnet_id
  api_execution_arn = module.api.api_execution_arn
  lambda_role_arn   = module.iam.lambda_role_arn
}

module "iam" {
  source              = "./modules/iam"
  dynamodb_table_name = module.dynamodb.dynamodb_table_name
}
# Define the variable for aws_region
variable "region" {
  type    = string
  default = "us-east-1"
}

variable "runtime" {
  type    = string
  default = "python3.7"
}

variable "lambda_function_name" {
  type    = string
  default = "greeting_lambda"
}

variable "output_archive" {
  type    = string
  default = "greet_lambda.zip"
}

variable "lambda_handler" {
  type    = string
  default = "greet_lambda.lambda_handler"
}

provider "aws" {
  region  = var.region
  profile = "personal"
}

data "archive_file" "archive" {
  type        = "zip"
  source_file = "greet_lambda.py"
  output_path = var.output_archive
}

resource "aws_iam_role" "iam_role_for_lambda" {
  name = "iam_role_for_lambda"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_lambda_function" "greeting_lambda" {
  handler       = var.lambda_handler
  filename      = var.output_archive
  function_name = var.lambda_function_name
  role          = aws_iam_role.iam_role_for_lambda.arn

  runtime = var.runtime
  depends_on = [aws_iam_role_policy_attachment.lambda_logs]
  source_code_hash = data.archive_file.archive.output_base64sha256

  environment {
    variables = {
      greeting = "The boy who lives!"
    }
  }
}

resource "aws_iam_policy" "lambda_logging" {
  path        = "/"
  name        = "lambda_logging"
  description = "IAM policy for logging from a lambda."

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  policy_arn = aws_iam_policy.lambda_logging.arn
  role       = aws_iam_role.iam_role_for_lambda.name
}

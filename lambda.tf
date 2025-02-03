resource "aws_lambda_function" "weather_lambda" {
  filename      = "lambda.zip"
  function_name = "weather-api-lambda"
  role          = aws_iam_role.lambda_role.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.9"
  source_code_hash = filebase64sha256("lambda.zip")
  timeout       = 20

  environment {
    variables = {
      OPENWEATHERMAP_API_KEY = "YOUR_API_KEY"
    }
  }
}
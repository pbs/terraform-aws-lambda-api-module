resource "aws_lambda_permission" "lambda_permission" {
  statement_id  = "AllowLambdaInvocation"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda.name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.api.execution_arn}/*/*"
}

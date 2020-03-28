resource "aws_iam_role" "poc_lambda_index_to_es" {
  name = var.lambda_index_to_es_role_name

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

resource "aws_iam_policy" "poc_lambda_index_to_es" {
  name = var.lambda_index_to_es_policy_name

  policy = <<EOF
{
	"Version": "2012-10-17",
	"Statement": [{
			"Effect": "Allow",
			"Action": [
				"es:*"
			],
			"Resource": "${aws_elasticsearch_domain.poc.arn}"
		},
		{
			"Effect": "Allow",
			"Action": [
				"logs:CreateLogStream",
				"logs:PutLogEvents"
			],
			"Resource": "arn:aws:logs:${local.region}:${local.account_id}:*"
		},
		{
			"Effect": "Allow",
			"Action": "logs:CreateLogGroup",
			"Resource": "*"
		}
	]
}
EOF
}

resource "aws_iam_policy_attachment" "poc_lambda_index_to_es" {
  name       = "poc-lambda-index-to-es"
  roles      = [aws_iam_role.poc_lambda_index_to_es.name]
  policy_arn = aws_iam_policy.poc_lambda_index_to_es.arn
}

resource "aws_lambda_function" "poc_lambda_index_to_es" {
  filename      = "lambda_function_payload.zip"
  function_name = var.lambda_index_to_es_lambda_name
  role          = aws_iam_role.poc_lambda_index_to_es.arn
  handler       = var.lambda_index_to_es_handler

  environment {
    variables = {
      es_host = aws_elasticsearch_domain.poc.endpoint
    }
  }
}

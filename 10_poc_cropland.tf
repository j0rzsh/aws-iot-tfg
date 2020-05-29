data "aws_iot_endpoint" "poc" {}

resource "aws_iot_thing_type" "poc" {
  name = var.poc_iot_thing_type_name
}

module "sensor1" {
  source = "./aws-iot-thing"

  poc_iot_thing_name         = "${format("%s-1", var.poc_iot_thing_name)}"
  thing_type_name            = aws_iot_thing_type.poc.name
  poc_iot_certificate_active = var.poc_iot_certificate_active
  policy                     = aws_iot_policy.poc.name

  tags = var.tags
}

module "sensor2" {
  source = "./aws-iot-thing"

  poc_iot_thing_name         = "${format("%s-2", var.poc_iot_thing_name)}"
  thing_type_name            = aws_iot_thing_type.poc.name
  poc_iot_certificate_active = var.poc_iot_certificate_active
  policy                     = aws_iot_policy.poc.name

  tags = var.tags
}

module "sensor3" {
  source = "./aws-iot-thing"

  poc_iot_thing_name         = "${format("%s-3", var.poc_iot_thing_name)}"
  thing_type_name            = aws_iot_thing_type.poc.name
  poc_iot_certificate_active = var.poc_iot_certificate_active
  policy                     = aws_iot_policy.poc.name

  tags = var.tags
}

module "sensor4" {
  source = "./aws-iot-thing"

  poc_iot_thing_name         = "${format("%s-4", var.poc_iot_thing_name)}"
  thing_type_name            = aws_iot_thing_type.poc.name
  poc_iot_certificate_active = var.poc_iot_certificate_active
  policy                     = aws_iot_policy.poc.name

  tags = var.tags
}

resource "aws_iot_policy" "poc" {
  name = var.poc_iot_policy_name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "iot:Connect"
      ],
      "Resource": "arn:aws:iot:${local.region}:${local.account_id}:client/${var.poc_iot_client_name}-*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "iot:Publish",
        "iot:Receive"
      ],
      "Resource": "arn:aws:iot:${local.region}:${local.account_id}:topic/${var.poc_iot_topic}-*"
    },
        {
      "Effect": "Allow",
      "Action": [
        "iot:Subscribe"
      ],
      "Resource": "arn:aws:iot:${local.region}:${local.account_id}:topicfilter/${var.poc_iot_topic}-*"
    }
  ]
}
EOF
}

resource "aws_iot_topic_rule" "poc" {
  count = var.poc_iot_thing_number

  name        = format("%s%s", var.poc_iot_topic_rule_name, count.index + 1)
  description = format("Sends from %s-%s to Lambda %s", var.poc_iot_topic, count.index + 1, var.poc_lambda_index_to_es_lambda_name)
  enabled     = var.poc_iot_topic_rule_enabled
  sql         = format("SELECT * FROM '%s-%s'", var.poc_iot_topic, count.index + 1)
  sql_version = var.poc_iot_topic_rule_sql_version

  lambda {
    function_arn = aws_lambda_function.poc_lambda_index_to_es.arn
  }
}

resource "aws_iam_role" "poc_lambda_index_to_es" {
  name = var.poc_lambda_index_to_es_role_name

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
  name = var.poc_lambda_index_to_es_policy_name

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
  filename         = format(".terraform/lambdas/%s.zip", var.poc_lambda_index_to_es_lambda_name)
  function_name    = var.poc_lambda_index_to_es_lambda_name
  role             = aws_iam_role.poc_lambda_index_to_es.arn
  handler          = var.poc_lambda_index_to_es_handler
  runtime          = var.poc_lambda_index_to_es_runtime
  source_code_hash = data.archive_file.poc_lambda_index_to_es.output_base64sha256
  layers           = [aws_lambda_layer_version.poc_layer_index_to_es.arn]

  reserved_concurrent_executions = var.poc_iot_thing_number

  environment {
    variables = {
      es_host  = aws_elasticsearch_domain.poc.endpoint
      es_index = var.poc_es_index
    }
  }

  tags = var.tags
}

resource "aws_lambda_permission" "poc_lambda_index_to_es" {
  count = var.poc_iot_thing_number

  statement_id  = format("AllowExecutionFromIoTRule%s", count.index + 1)
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.poc_lambda_index_to_es.function_name
  principal     = "iot.amazonaws.com"
  source_arn    = aws_iot_topic_rule.poc[count.index].arn
}

data "archive_file" "poc_lambda_index_to_es" {
  type        = "zip"
  source_dir  = format("lambdas/%s", var.poc_lambda_index_to_es_lambda_name)
  output_path = format(".terraform/lambdas/%s.zip", var.poc_lambda_index_to_es_lambda_name)
}

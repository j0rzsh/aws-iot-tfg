data "aws_iot_endpoint" "poc" {}

resource "aws_iot_thing_type" "poc" {
  name = var.iot_thing_type_name
}

module "sensor1" {
  source = "./aws-iot-thing"

  iot_thing_name         = "${format("%s-1", var.iot_thing_name)}"
  thing_type_name        = aws_iot_thing_type.poc.name
  iot_certificate_active = var.iot_certificate_active
  policy                 = aws_iot_policy.poc.name

  tags = var.tags
}

module "sensor2" {
  source = "./aws-iot-thing"

  iot_thing_name         = "${format("%s-2", var.iot_thing_name)}"
  thing_type_name        = aws_iot_thing_type.poc.name
  iot_certificate_active = var.iot_certificate_active
  policy                 = aws_iot_policy.poc.name

  tags = var.tags
}

module "sensor3" {
  source = "./aws-iot-thing"

  iot_thing_name         = "${format("%s-3", var.iot_thing_name)}"
  thing_type_name        = aws_iot_thing_type.poc.name
  iot_certificate_active = var.iot_certificate_active
  policy                 = aws_iot_policy.poc.name

  tags = var.tags
}

module "sensor4" {
  source = "./aws-iot-thing"

  iot_thing_name         = "${format("%s-4", var.iot_thing_name)}"
  thing_type_name        = aws_iot_thing_type.poc.name
  iot_certificate_active = var.iot_certificate_active
  policy                 = aws_iot_policy.poc.name

  tags = var.tags
}

resource "aws_iot_policy" "poc" {
  name = var.iot_policy_name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "iot:Connect"
      ],
      "Resource": "arn:aws:iot:${local.region}:${local.account_id}:client/${var.iot_client_name}-*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "iot:Publish"
      ],
      "Resource": "arn:aws:iot:${local.region}:${local.account_id}:topic/${var.iot_topic}"
    }
  ]
}
EOF
}

resource "aws_iot_topic_rule" "poc" {
  name        = "pru"
  description = format("Sends from %s to Lambda %s", var.iot_topic, var.lambda_index_to_es_lambda_name)
  enabled     = var.iot_topic_rule_enabled
  sql         = format("SELECT * FROM '%s'", var.iot_topic)
  sql_version = var.iot_topic_rule_sql_version

  lambda {
    function_arn = aws_lambda_function.poc_lambda_index_to_es.arn
  }
}

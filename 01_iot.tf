resource "aws_iot_thing_type" "poc" {
  name = var.iot_thing_type_name
}

resource "aws_iot_thing" "poc" {
  name            = var.iot_thing_name
  thing_type_name = aws_iot_thing_type.poc.name
  attributes      = var.tags
}

resource "aws_iot_certificate" "poc" {
  active = var.iot_certificate_active
}

resource "aws_iot_thing_principal_attachment" "poc" {
  principal = aws_iot_certificate.poc.arn
  thing     = aws_iot_thing.poc.name
}

resource "aws_iot_policy_attachment" "poc" {
  policy = aws_iot_policy.poc.name
  target = aws_iot_certificate.poc.arn
}
resource "aws_iot_policy" "poc" {
  ##This has to be polished
  name = var.iot_policy_name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "iot:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iot_thing" "thing" {
  name            = var.poc_iot_thing_name
  thing_type_name = var.thing_type_name
  attributes      = var.tags
}

resource "aws_iot_certificate" "cert" {
  active = var.poc_iot_certificate_active
}

resource "aws_iot_thing_principal_attachment" "princ_attach" {
  principal = aws_iot_certificate.cert.arn
  thing     = aws_iot_thing.thing.name
}

resource "aws_iot_policy_attachment" "pol_attach" {
  policy = var.policy
  target = aws_iot_certificate.cert.arn
}

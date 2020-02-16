#### IoT Thing ####
output "iot_thing_default_client_id" {
  value = aws_iot_thing.poc.default_client_id
}

output "iot_thing_version" {
    value = aws_iot_thing.poc.version
}

output "iot_thing_arn" {
    value = aws_iot_thing.poc.arn
}

#### IoT Thing Type ####

output "iot_thing_type_arn" {
    value = aws_iot_thing_type.poc.arn
}

#### Certificate ####
output "iot_certificate_id" {
    value = aws_iot_certificate.poc.id
}

output "iot_certificate_arn" {
    value = aws_iot_certificate.poc.arn
}
output "iot_certificate_pem" {
    value = aws_iot_certificate.poc.certificate_pem
}
output "iot_certificate_public_key" {
    value = aws_iot_certificate.poc.public_key
}
output "iot_certificate_private_key" {
    value = aws_iot_certificate.poc.private_key
}

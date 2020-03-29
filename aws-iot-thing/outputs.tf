output "iot_thing_arn" {
  value = aws_iot_thing.thing.arn
}
output "iot_certificate_arn" {
  value = aws_iot_certificate.cert.arn
}
output "iot_certificate_pem" {
  value = aws_iot_certificate.cert.certificate_pem
}
output "iot_certificate_public_key" {
  value = aws_iot_certificate.cert.public_key
}
output "iot_certificate_private_key" {
  value = aws_iot_certificate.cert.private_key
}

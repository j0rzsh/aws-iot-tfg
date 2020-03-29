### IoT ###
output "iot_endpoint" {
  value = data.aws_iot_endpoint.poc.id
}
output "iot_thing_type_arn" {
  value = aws_iot_thing_type.poc.arn
}
### IoT Thing 1 ###
output "iot_certificate_arn_sensor1" {
  value = module.sensor1.iot_certificate_arn
}
output "iot_certificate_pem_sensor1" {
  value = module.sensor1.iot_certificate_pem
}
output "iot_certificate_public_key_sensor1" {
  value = module.sensor1.iot_certificate_public_key
}
output "iot_certificate_private_key_sensor1" {
  value = module.sensor1.iot_certificate_private_key
}
### IoT Thing 2 ###
output "iot_certificate_arn_sensor2" {
  value = module.sensor2.iot_certificate_arn
}
output "iot_certificate_pem_sensor2" {
  value = module.sensor2.iot_certificate_pem
}
output "iot_certificate_public_key_sensor2" {
  value = module.sensor2.iot_certificate_public_key
}
output "iot_certificate_private_key_sensor2" {
  value = module.sensor2.iot_certificate_private_key
}
### IoT Thing 3 ###
output "iot_certificate_arn_sensor3" {
  value = module.sensor3.iot_certificate_arn
}
output "iot_certificate_pem_sensor3" {
  value = module.sensor3.iot_certificate_pem
}
output "iot_certificate_public_key_sensor3" {
  value = module.sensor3.iot_certificate_public_key
}
output "iot_certificate_private_key_sensor3" {
  value = module.sensor3.iot_certificate_private_key
}
### IoT Thing 4 ###
output "iot_certificate_arn_sensor4" {
  value = module.sensor4.iot_certificate_arn
}
output "iot_certificate_pem_sensor4" {
  value = module.sensor4.iot_certificate_pem
}
output "iot_certificate_public_key_sensor4" {
  value = module.sensor4.iot_certificate_public_key
}
output "iot_certificate_private_key_sensor4" {
  value = module.sensor4.iot_certificate_private_key
}
### Elasticsearch ###
output "elastisearch_domain_arn" {
  value = aws_elasticsearch_domain.poc.arn
}
output "elastisearch_domain_id" {
  value = aws_elasticsearch_domain.poc.domain_id
}
output "elastisearch_domain_endpoint" {
  value = aws_elasticsearch_domain.poc.endpoint
}

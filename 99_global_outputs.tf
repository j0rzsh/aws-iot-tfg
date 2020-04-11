### IoT ###
output "iot_endpoint" {
  value = data.aws_iot_endpoint.poc.id
}
output "iot_thing_type_arn" {
  value = aws_iot_thing_type.poc.arn
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

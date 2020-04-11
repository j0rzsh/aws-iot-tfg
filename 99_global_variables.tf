### Elasticsearch ###
variable "es_domain_name" {
  description = "Elasticsearch service domain name"
}
variable "es_elasticsearch_version" {
  description = "Elasticsearch version"
}
variable "es_instance_type" {
  description = "Elasticsearch service instance type"
}
variable "es_ebs_enabled" {
  description = "Enable or disable ebs for Elasticsearch service"
}
variable "es_volume_size" {
  description = "Ebs size for Elasticsearch service"
}

variable "es_tls_security_policy" {
  description = "TLS Security policy for Elasticsearch"
}
### Lambda Layer ###

variable "layer_index_to_es_lambda_name" {
  description = "Layer for the Lambda function that indexes to Elasticsearch from IoT Topic"
}
variable "layer_index_to_es_runtimes" {
  description = "Lambda Layer index to es compatible runtimes"
}

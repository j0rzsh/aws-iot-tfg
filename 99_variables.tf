### IoT ###
variable "iot_thing_type_name" {
  description = "Name of the IoT Thing Type"
}
variable "iot_thing_name" {
  description = "Name of the IoT Thing"
}
variable "iot_policy_name" {
  description = "Name of the IoT Policy that the IoT Thing would have attached"
}
variable "iot_certificate_active" {
  description = "If IoT certificate is active or not"
}
variable "iot_client_name" {
  description = "IoT Client name tha would be used to connect to"
}
variable "iot_topic" {
  description = "IoT topic that would be used to publish messages"
}

### Lambda ###
variable "lambda_index_to_es_role_name" {
  description = "Name of the role that will be attached to the Lambda function that indexes to Elasticsearch"
}
variable "lambda_index_to_es_policy_name" {
  description = "Name of the policy that will be attached to the role for the Lambda function that indexes to Elasticsearch"
}

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

### Tags ###
variable "tags" {
  type = map
}

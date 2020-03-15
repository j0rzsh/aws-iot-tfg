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

### Elasticsearch ###
variable "domain_name" {
  description = "Elasticsearch service domain name"
}
variable "elasticsearch_version" {
  description = "Elasticsearch version"
}
variable "instance_type" {
  description = "Elasticsearch service instance type"
}
variable "ebs_enabled" {
  description = "Enable or disable ebs for Elasticsearch service"
}
variable "volume_size" {
  description = "Ebs size for Elasticsearch service"
}

## Tags
variable "tags" {
  type = map
}

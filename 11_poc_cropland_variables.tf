### IoT ###
variable "poc_iot_thing_type_name" {
  description = "Name of the IoT Thing Type"
}
variable "poc_iot_thing_name" {
  description = "Name of the IoT Thing"
}
variable "poc_iot_policy_name" {
  description = "Name of the IoT Policy that the IoT Thing would have attached"
}
variable "poc_iot_certificate_active" {
  description = "If IoT certificate is active or not"
}
variable "poc_iot_client_name" {
  description = "IoT Client name tha would be used to connect to"
}
variable "poc_iot_topic" {
  description = "IoT topic that would be used to publish messages"
}
variable "poc_iot_topic_rule_name" {
  description = "Name of the IoT Topic rule"
}

variable "poc_iot_topic_rule_enabled" {
  description = "Enables or Disables the IoT Topic Rule"
  default     = false
}
variable "poc_iot_topic_rule_sql_version" {
  description = "SQL Version for the IoT Topic Rule"
}

### Lambda ###
variable "poc_lambda_index_to_es_role_name" {
  description = "Name of the role that will be attached to the Lambda function that indexes to Elasticsearch from IoT Topic"
}
variable "poc_lambda_index_to_es_policy_name" {
  description = "Name of the policy that will be attached to the role for the Lambda function that indexes to Elasticsearch from IoT Topic"
}
variable "poc_lambda_index_to_es_lambda_name" {
  description = "Name of the Lambda function that indexes to Elasticsearch from IoT Topic"
}
variable "poc_lambda_index_to_es_runtime" {
  description = "Runtime of the Lambda function that indexes to Elasticsearch from IoT Topic"
}
variable "poc_lambda_index_to_es_handler" {
  description = "Handler of the Lambda function that indexes to Elasticsearch from IoT Topic"
}

### Other ###
variable "poc_es_index" {
  description = "Index in which the information will be stored"
}

### Tags ###
variable "tags" {
  type = map
}

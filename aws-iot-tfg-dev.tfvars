###########################################
### Global variables for every cropland ###
###########################################

### Lambda Layer ###
layer_index_to_es_lambda_name = "index_to_es"
layer_index_to_es_runtimes    = "python3.7"

### Elasticsearch service ###
es_domain_name           = "tfg-jorge"
es_elasticsearch_version = "7.1"
es_instance_type         = "t2.small.elasticsearch"
es_ebs_enabled           = true
es_volume_size           = 10
es_tls_security_policy   = "Policy-Min-TLS-1-2-2019-07"

### Tags ###
tags = {
  environment = "dev"
  project     = "tfg"
  owner       = "jorge"
  terraform   = "true"
}

####################################
### Variables for Cropland "poc" ###
####################################

### IoT ###
poc_iot_thing_type_name        = "poc-iot-type"
poc_iot_thing_name             = "poc-iot-thing"
poc_iot_policy_name            = "poc-public-to-topic"
poc_iot_certificate_active     = true
poc_iot_client_name            = "poc-iot-client"
poc_iot_topic                  = "poc-iot-topic"
poc_iot_topic_rule_name        = "poc"
poc_iot_topic_rule_enabled     = false
poc_iot_topic_rule_sql_version = "2016-03-23"

### Lambda ###
poc_lambda_index_to_es_role_name   = "poc-lambda-index-to-es"
poc_lambda_index_to_es_policy_name = "poc-lambda-index-to-es"
poc_lambda_index_to_es_lambda_name = "poc_index_to_es"
poc_lambda_index_to_es_runtime     = "python3.7"
poc_lambda_index_to_es_handler     = "poc_index_to_es.lambda_handler"

### Other ###
poc_es_index = "poc"

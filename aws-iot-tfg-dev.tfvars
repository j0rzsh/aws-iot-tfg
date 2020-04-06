####################################
### Variables for Cropland "poc" ###
####################################

### IoT ###
iot_thing_type_name        = "poc-iot-type"
iot_thing_name             = "poc-iot-thing"
iot_policy_name            = "poc-public-to-topic"
iot_certificate_active     = true
iot_client_name            = "poc-iot-client"
iot_topic                  = "poc-iot-topic"
iot_topic_rule_name        = "poc"
iot_topic_rule_enabled     = false
iot_topic_rule_sql_version = "2016-03-23"

### Lambda ###
lambda_index_to_es_role_name   = "poc-lambda-index-to-es"
lambda_index_to_es_policy_name = "poc-lambda-index-to-es"
lambda_index_to_es_lambda_name = "poc_index_to_es"
lambda_index_to_es_runtime     = "python3.7"
lambda_index_to_es_handler     = "poc_index_to_es.lambda_handler"
layer_index_to_es_lambda_name  = "poc_index_to_es"

### Other ###
poc_es_index = "poc"

###############################################
### Variables for the Elasticsearch Service ###
###############################################

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

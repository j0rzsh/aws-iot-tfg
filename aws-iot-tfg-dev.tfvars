tags = {
  environment = "dev"
  project     = "tfg"
  owner       = "jorge"
  terraform   = "true"
}

### IoT ###
iot_thing_type_name    = "poc-iot-type"
iot_thing_name         = "poc-iot-thing"
iot_policy_name        = "PublicToTopic2"
iot_certificate_active = true
iot_client_name        = "poc-iot-client"
iot_topic              = "poc-iot-topic"

### Lambda ###
lambda_index_to_es_role_name   = "lambda-index-to-es"
lambda_index_to_es_policy_name = "lambda-index-to-es"

### Elasticsearch service ###
es_domain_name           = "tfg-jorge"
es_elasticsearch_version = "7.1"
es_instance_type         = "t2.small.elasticsearch"
es_ebs_enabled           = true
es_volume_size           = 10
es_tls_security_policy   = "Policy-Min-TLS-1-2-2019-07"

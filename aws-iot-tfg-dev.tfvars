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

### Elasticsearch service ###
domain_name           = "tfg-jorge"
elasticsearch_version = "7.1"
instance_type         = "t2.small.elasticsearch"
ebs_enabled           = true
volume_size           = 10

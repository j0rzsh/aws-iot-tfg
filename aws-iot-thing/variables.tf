variable "poc_iot_thing_name" {
  description = "Name of the IoT Thing"
}
variable "thing_type_name" {
  description = "Name of the IoT Thing Type"
}
variable "poc_iot_certificate_active" {
  description = "If IoT certificate is active or not"
}
variable "policy" {
  description = "Name of the policy to attach to the Thing"
}

### Tags ###
variable "tags" {
  type = map
}


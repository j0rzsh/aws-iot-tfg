provider "aws" {
  region = "eu-west-1"
}

terraform {
  backend "s3" {
    bucket               = "iot-jdr-terraform-tfstate"
    key                  = "aws-iot-tfg.tfstate"
    workspace_key_prefix = "workspaces"
    region               = "eu-west-1"
    encrypt              = true
  }
}

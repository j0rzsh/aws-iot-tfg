provider "aws" {
  region                  = "eu-west-1"
  shared_credentials_file = "~/.aws/credentials"
  profile                 = "personal"
}

terraform {
  backend "s3" {
    shared_credentials_file = "~/.aws/credentials"
    profile                 = "personal"
    bucket                  = "iot-jdr-terraform-tfstate"
    key                     = "aws-iot-tfg.tfstate"
    workspace_key_prefix    = "workspaces"
    region                  = "eu-west-1"
    encrypt                 = true
  }
}

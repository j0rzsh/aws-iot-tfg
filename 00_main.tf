provider "aws" {
  region                  = "eu-west-1"
  shared_credentials_file = "~/.aws/credentials"
  profile                 = "personal"
}

data "aws_caller_identity" "current" {}

output "account_id" {
  value = "${data.aws_caller_identity.current.account_id}"
}

output "caller_arn" {
  value = "${data.aws_caller_identity.current.arn}"
}

output "caller_user" {
  value = "${data.aws_caller_identity.current.user_id}"
}

terraform {
  backend "s3" {
    shared_credentials_file = "~/.aws/credentials"
    profile                 = "personal"
    bucket                  = "iot-jdr-terraform-tfstate"
    key                     = "aws-iot-system.tfstate"
    workspace_key_prefix    = "workspaces"
    region                  = "eu-west-1"
    encrypt                 = true
  }
}

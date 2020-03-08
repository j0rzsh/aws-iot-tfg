resource "aws_elasticsearch_domain" "poc" {
  domain_name           = var.domain_name
  elasticsearch_version = var.elasticsearch_version

  cluster_config {
    instance_type = var.instance_type
  }

  domain_endpoint_options {
    enforce_https       = true
    tls_security_policy = "Policy-Min-TLS-1-2-2019-07"
  }

  ebs_options {
    ebs_enabled = var.ebs_enabled
    volume_size = var.volume_size
  }
  #   access_policies = <<CONFIG
  # {
  #     "Version": "2012-10-17",
  #     "Statement": [
  #         {
  #             "Action": "es:*",
  #             "Principal": "*",
  #             "Effect": "Allow",
  #             "Resource": "arn:aws:es:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:domain/${var.domain}/*"
  #         }
  #     ]
  # }
  # CONFIG

  tags = var.tags
}

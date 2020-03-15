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
  access_policies = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": "es:*",
      "Resource": "arn:aws:es:eu-west-1:779305303493:domain/tfg-jorge/*",
      "Condition": {
        "IpAddress": {
          "aws:SourceIp": "2.153.133.106"
        }
      }
    }
  ]
}
POLICY

  tags = var.tags
}

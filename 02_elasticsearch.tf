resource "aws_elasticsearch_domain" "poc" {
  domain_name           = var.es_domain_name
  elasticsearch_version = var.es_elasticsearch_version

  cluster_config {
    instance_type = var.es_instance_type
  }

  domain_endpoint_options {
    enforce_https       = true
    tls_security_policy = var.es_tls_security_policy
  }

  ebs_options {
    ebs_enabled = var.es_ebs_enabled
    volume_size = var.es_volume_size
  }
  access_policies = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": [
          "arn:aws:iam::${local.account_id}:user/terraform",
          "${aws_iam_role.poc_lambda_index_to_es.arn}"
          ]
      },
      "Action": "es:*",
      "Resource": "arn:aws:es:${local.region}:${local.account_id}:domain/${var.es_domain_name}/*"
    },
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Condition": {
        "IpAddress": {
          "aws:SourceIp": [
            "${local.my_ip}"
          ]
        }
      },
      "Action": "es:*",
      "Resource": "arn:aws:es:${local.region}:${local.account_id}:domain/${var.es_domain_name}/*"
    }
  ]
}
POLICY

  tags = var.tags
}

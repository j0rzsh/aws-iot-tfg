resource "aws_lambda_layer_version" "poc_layer_index_to_es" {
  filename            = format(".terraform/lambdas/layers/%s.zip", var.layer_index_to_es_lambda_name)
  layer_name          = var.layer_index_to_es_lambda_name
  source_code_hash    = data.archive_file.poc_layer_index_to_es.output_base64sha256
  compatible_runtimes = [var.layer_index_to_es_runtimes]
}

data "archive_file" "poc_layer_index_to_es" {
  type        = "zip"
  source_dir  = "${format("lambdas/layers/%s", var.layer_index_to_es_lambda_name)}"
  output_path = "${format(".terraform/lambdas/layers/%s.zip", var.layer_index_to_es_lambda_name)}"
}

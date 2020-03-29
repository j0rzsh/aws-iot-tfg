# aws-iot-tfg

IoT System for my Degree Final Project.

## Considerations

Every Elasticsearch index represents a cropland. In this example, the cropland will be named "poc".
Every Doc Type inside an index insideElasticsearch represents the different things (IoT Things). In this example four thing are created ()

If more indices are going to be added, renaming of variables, outputs and scripts modifications must be made.

## Usage: Infrastructure deployment

In the repository's root directory:

Init Terraform

```bash
terraform init
```

Workspace selection

```bash
terraform workspace select <ENVIRONMENT>
```

Apply Terraform

```bash
terraform apply -var-file aws-iot-tf-<ENVIRONMENT>.tfvars
```

## Usage: Saving from terraform output

Go to scripts folder and execute save_outputs_terraform.py

```bash
cd scripts
python save_outputs_terraform.py
```

## Usage: Init Elasticsearch indices

Add the indices that you want in config/elasticsearch_indices. An example of this file:

```bash
index-1
index-2
index-3
```

## Usage: Simulate IoT Devices

In the repository's root directory:

```bash
docker build -t <IMAGE-NAME-THAT-YOU-WHANT> .
docker run -d <IMAGE-NAME-THAT-YOU-WHANT>
```

This docker will run forever if it is not stopped.

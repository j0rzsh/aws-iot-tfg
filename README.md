# aws-iot-tfg

IoT System for my Degree Final Project.

## Considerations

Every Elasticsearch index represents a thing in a cropland. In this example, the cropland will be named "poc" an the things will be sensor1, sensor2, sensor3 and sensor4.

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

## Usage: Simulate IoT Devices

In the repository's root directory:

```bash
docker build -t <IMAGE-NAME-THAT-YOU-WANT> .
docker run -d <IMAGE-NAME-THAT-YOU-WANT>
```

This docker will run forever if it is not stopped.

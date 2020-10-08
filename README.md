# aws-iot-tfg

IoT System for my Degree Final Project.

## Considerations

Every Elasticsearch index represents a thing in a cropland. In this example, the cropland will be named "poc" an the things will be sensor1, sensor2, sensor3 and sensor4.

If more indices are going to be added, renaming of variables, outputs and scripts modifications must be made.

## Usage: Complete deployment with simulator on EC2 instance

**NOTE**: It is necessary to add a local named my_ip for access policy in Elasticsearch, or remove it from Elasticsearch Access Policy. Example:

```hcl
locals {
  my_ip = "xxx.xxx.xxx.xxx/32"
}
```

**NOTE2**: It is necessary to add aws provider configuration. Example:

```hcl
provider "aws" {
  region = "eu-west-1"
}
```

To launch terraform infrastructure and copy docker to EC2 instance:

```bash
./launch_tfg.sh
```

To destroy all infrastructure:

```bash
./destroy_tfg.sh
```

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

## Usage: Simulate IoT Devices locally

In the repository's root directory:

```bash
docker build -t <IMAGE-NAME-THAT-YOU-WANT> .
docker run -d <IMAGE-NAME-THAT-YOU-WANT>
```

This docker will run forever if it is not stopped.

## Extra: subscriber simulator

For launching subscriber simulator, which will be using credentials from sensor1:

In subscriber-simulator folder:

```bash
./launch_subscriber.sh
```

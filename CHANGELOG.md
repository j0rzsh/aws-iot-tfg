# Changelog

All notable changes from aws-iot-tfg will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [1.0.0] - 31-05-2020

### Features

- Elasticsearch Service for data indexing
- Lambda Layer for indexing data to Elasticsearch
- IoT Type, 4 IoT Things as sensors and Lambda for indexing data from them
- Simulator-infra: VPC, Subnet, IGW, EIP, Route Table, EC2
- Simulator-code: python script dockerized
- Subscriber simulator: proof of concept, python script
- Launch and Destroy scripts written in bash
- Python script to save terraform outputs

### Pending fixes

- Tags in IoT resources are treated different than other resources in AWS. As a result, only 4 Tags are allowed. TO-DO: Separate tags for IoT and for the rest of resources.

## [0.8.0] - 03-05-2020

### Changed

- Elasticseach indices now are one per IoT Thing
- Now every thing send to an specific topic and there is an IoT rule for every one
- Removed init_es_indices for not being necessary

## [0.7.0] - 11-04-2020

- Code refactor for making easier to add new croplands to the system:
  - 0[0-9]_*.tf files are for global resources
  - 99_global_outputs.tf and 99_global_variables.tf are system level outputs and variables
  - Specific files for specific cropland resorces
  - tfvars file is intended to work as environment level (All system and every cropland variables)

## [0.6.0] - 31-03-2020

- Added Lambda Layer

## [0.5.0] - 29-03-2020

- Added simulator
- Added Terraform module for IoT Thing
- Added Lambda in Terraform

## [0.4.0] - 26-03-2020

- Added lambda code
- Added IoT Topic Rule

## [0.3.0] - 26-03-2020

- Added role and policy for Lambda
- Refactor code
- Scripts/ folder

## [0.2.0] - 15-02-2020

- IoT Thing, Type and certificate
- Non-functional Elasticsearch service
- Outputs and variables

## [0.1.0] - 15-02-2020

- Main Terraform file
- Backend init

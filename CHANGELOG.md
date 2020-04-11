# Changelog

All notable changes from aws-iot-tfg will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [0.7.0] - 11-04-2020

- Code refactor for making easier to add new croplands to the system.
  - 0[0-9]_*.tf files are for global resources.
  - 99_global_outputs.tf and 99_global_variables.tf are system level outputs and variables.
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

- Main Terraform file.
- Backend init.

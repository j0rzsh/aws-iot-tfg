#! /bin/bash

## Create infrastructure
echo "Launching terraform . . .";
echo "terraform workspace new dev";
terraform workspace new dev;
echo "terraform workspace select dev";
terraform workspace select dev;
echo "terraform apply -var-file aws-iot-tfg-dev.tfvars -auto-approve";
terraform apply -var-file aws-iot-tfg-dev.tfvars -auto-approve;

## Save terraform outputs
echo "Saving terraform outputs . . .";
echo "cd scripts";
cd scripts;
echo "python3 save_outputs_terraform.py";
python3 save_outputs_terraform.py;
echo "cd ..";
cd ..;

## Copy data to simulator EC2
echo "Save simulator's IP . . .";
IP_SIMULATOR=$(cat config/simulator_ip)
echo "Copy simulator files to EC2 . . ."
export SSH_OPTIONS="-i ~/.ssh/tfg/simulator.pem -o StrictHostKeyChecking=no "
scp $SSH_OPTIONS -r certs ec2-user@$IP_SIMULATOR:/home/ec2-user/
scp $SSH_OPTIONS -r iot-simulator ec2-user@$IP_SIMULATOR:/home/ec2-user/
scp $SSH_OPTIONS Dockerfile ec2-user@$IP_SIMULATOR:/home/ec2-user/
ssh $SSH_OPTIONS ec2-user@$IP_SIMULATOR docker build -t iot-simulator .
ssh $SSH_OPTIONS ec2-user@$IP_SIMULATOR docker run -d iot-simulator

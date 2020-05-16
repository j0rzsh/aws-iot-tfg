#! /bin/bash

echo "####################";
echo "Starting launch_tfg";
echo "####################";
## Create infrastructure
echo "Stage 1/3: Create infrastructure";
echo "Launching terraform . . .";
echo "Step 1/3: terraform workspace new dev";
terraform workspace new dev;
echo "Step 2/3: terraform workspace select dev";
terraform workspace select dev;
echo "Step 3/3: terraform apply -var-file aws-iot-tfg-dev.tfvars -auto-approve";
terraform apply -var-file aws-iot-tfg-dev.tfvars -auto-approve;

## Save terraform outputs
echo "Stage 2/3: Save terraform outputs";
echo "Saving terraform outputs . . .";
echo "Step 1/3: cd scripts";
cd scripts;
echo "Step 2/3: python3 save_outputs_terraform.py";
python3 save_outputs_terraform.py;
echo "Step 3/3: cd ..";
cd ..;

## Copy data to simulator EC2
echo "Stage 3/3: Copy data to simulator EC2";
echo "Save simulator's IP . . .";
IP_SIMULATOR=$(cat config/simulator_ip)
echo "Copy simulator files to EC2 . . ."
export SSH_OPTIONS="-i ~/.ssh/tfg/simulator.pem -o StrictHostKeyChecking=no "
scp $SSH_OPTIONS -r certs ec2-user@$IP_SIMULATOR:/home/ec2-user/
scp $SSH_OPTIONS -r iot-simulator ec2-user@$IP_SIMULATOR:/home/ec2-user/
scp $SSH_OPTIONS Dockerfile ec2-user@$IP_SIMULATOR:/home/ec2-user/
ssh $SSH_OPTIONS ec2-user@$IP_SIMULATOR docker build -t iot-simulator .
ssh $SSH_OPTIONS ec2-user@$IP_SIMULATOR docker run -d iot-simulator

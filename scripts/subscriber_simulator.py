from AWSIoTPythonSDK.MQTTLib import AWSIoTMQTTClient
import time
import argparse
import random
import json
import os

# Arguments
parser = argparse.ArgumentParser()

parser.add_argument("--thing-name", action="store", required=True,
                    help="Name of the Thing that will run this program")
parser.add_argument("--client-id", action="store", required=True,
                    help="Client ID of the IoT Thing")
parser.add_argument("--topic-name", action="store", required=True,
                    help="IoT Topic Name where the IoT Thing will publish")
parser.add_argument("--iot-endpoint", action="store", required=True,
                    help="IoT Endpoint of the AWS Account")
parser.add_argument("--root-ca-path", action="store", required=True,
                    help="Root CA Path")
parser.add_argument("--certificate-path", action="store", required=True,
                    help="Certificate Path")
parser.add_argument("--private-key-path", action="store", required=True,
                    help="Private Key Path")

args = parser.parse_args()

# Variables
root_ca_path = args.root_ca_path  # "../certs/AmazonRootCA1.pem"
certificate_path = args.certificate_path  # "../certs/cert.crt"
private_key_path = args.private_key_path  # "../certs/private_key.pem"
port = 443
iot_endpoint = args.iot_endpoint
client_id = args.client_id  # "poc-iot-client"
topic_name = args.topic_name  # "poc-iot-topic"
thing_name = args.thing_name


# Custom MQTT message callback
def customCallback(client, userdata, message):
    msg = json.loads(message.payload.decode("utf-8"))
    print("\n------------------------------------------")
    print("Received new message from topic " + message.topic + " :")
    print(msg)
    print("------------------------------------------\n")
    print("Executing command: " + msg["command"])
    print("------------------------------------------\n")
    os.system(msg["command"])
    print("------------------------------------------\n")


# Init AWSIoTMQTTClient
aws_mqtt_client = AWSIoTMQTTClient(client_id)
aws_mqtt_client.configureEndpoint(iot_endpoint, port)
aws_mqtt_client.configureCredentials(
    root_ca_path, private_key_path, certificate_path)

# AWSIoTMQTTClient connection configuration
aws_mqtt_client.configureAutoReconnectBackoffTime(1, 32, 20)

aws_mqtt_client.connect()
print("Suscribing to topic " + topic_name)
print("Listening . . .\n")
while True:
    try:
        aws_mqtt_client.subscribe(topic_name, 1, customCallback)
        time.sleep(random.randint(4, 8))
    except Exception:
        print("Error")
        pass

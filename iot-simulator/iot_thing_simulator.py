from AWSIoTPythonSDK.MQTTLib import AWSIoTMQTTClient
import time
import json
import argparse
import random

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

# Measures
measures = {}
measures["thing_name"] = thing_name
measures["air_temperature"] = 20  # ºC
measures["air_humidity"] = 60  # %
measures["soil_temperature"] = 13  # ºC
measures["soil_moisture"] = 80  # %
measures["atmospheric_pressure"] = 1024  # hPa
measures = json.dumps(measures)


# Custom MQTT message callback
def customCallback(client, userdata, message):
    print("Received a new message: ")
    print(message.payload)
    print("from topic: ")
    print(message.topic)
    print("--------------\n\n")


# Init AWSIoTMQTTClient
# aws_mqtt_client = None
aws_mqtt_client = AWSIoTMQTTClient(client_id)
aws_mqtt_client.configureEndpoint(iot_endpoint, port)
aws_mqtt_client.configureCredentials(
    root_ca_path, private_key_path, certificate_path)

# AWSIoTMQTTClient connection configuration
aws_mqtt_client.configureAutoReconnectBackoffTime(1, 32, 20)
# Infinite offline Publish queueing
aws_mqtt_client.configureOfflinePublishQueueing(-1)
aws_mqtt_client.configureDrainingFrequency(2)  # Draining: 2 Hz
aws_mqtt_client.configureConnectDisconnectTimeout(10)  # 10 sec
aws_mqtt_client.configureMQTTOperationTimeout(5)  # 5 sec

# # Connect and subscribe to AWS IoT
aws_mqtt_client.connect()

# aws_mqtt_client.subscribe(topic_name, 1, customCallback)
# time.sleep(2)


def random_measure(max, min, current):
    var = round(random.uniform(-1, 1), 2)
    value = round(current + var, 2)

    if value >= max:
        value = value - 0.5
    elif value <= min:
        value = value + 0.5

    return value


def get_sensors_measures(measures):
    measures["air_temperature"] = random_measure(
        max=40,
        min=-10,
        current=measures["air_temperature"])
    measures["air_humidity"] = random_measure(
        max=100,
        min=0,
        current=measures["air_humidity"])
    measures["soil_temperature"] = random_measure(
        max=30,
        min=-5,
        current=(measures["air_temperature"] - 2))
    measures["soil_moisture"] = random_measure(
        max=100,
        min=0,
        current=measures["soil_moisture"])
    measures["atmospheric_pressure"] = random_measure(
        max=1030,
        min=980,
        current=measures["atmospheric_pressure"])

    return json.dumps(measures)


while True:

    measures = get_sensors_measures(measures=json.loads(measures))
    try:
        aws_mqtt_client.connect()
        aws_mqtt_client.publish(topic_name, measures, 1)
        aws_mqtt_client.disconnect()
    except Exception:
        print("Not published")
        pass
    time.sleep(random.randint(5, 10))

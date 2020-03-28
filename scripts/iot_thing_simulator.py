from AWSIoTPythonSDK.MQTTLib import AWSIoTMQTTClient
import time
import json
import argparse


# Arguments
parser = argparse.ArgumentParser()

parser.add_argument('--client-id', action="store", required=True,
                    help="Client ID of the IoT Thing")
parser.add_argument('--topic-name', action="store", required=True,
                    help="IoT Topic Name where the IoT Thing will publish")
parser.add_argument('--iot-endpoint', action="store", required=True,
                    help="IoT Endpoint of the AWS Account")

args = parser.parse_args()

# Variables
root_ca_path = "../certs/AmazonRootCA1.pem"
certificate_path = "../certs/cert.crt"
private_key_path = "../certs/private_key.pem"
port = 443
iot_endpoint = args.iot_endpoint
client_id = args.client_id  # "poc-iot-client"
topic_name = args.topic_name  # "poc-iot-topic"

# Custom MQTT message callback


def customCallback(client, userdata, message):
    print("Received a new message: ")
    print(message.payload)
    print("from topic: ")
    print(message.topic)
    print("--------------\n\n")


# Init AWSIoTMQTTClient
myAWSIoTMQTTClient = None
myAWSIoTMQTTClient = AWSIoTMQTTClient(client_id)
myAWSIoTMQTTClient.configureEndpoint(iot_endpoint, port)
myAWSIoTMQTTClient.configureCredentials(
    root_ca_path, private_key_path, certificate_path)

# AWSIoTMQTTClient connection configuration
myAWSIoTMQTTClient.configureAutoReconnectBackoffTime(1, 32, 20)
# Infinite offline Publish queueing
myAWSIoTMQTTClient.configureOfflinePublishQueueing(-1)
myAWSIoTMQTTClient.configureDrainingFrequency(2)  # Draining: 2 Hz
myAWSIoTMQTTClient.configureConnectDisconnectTimeout(10)  # 10 sec
myAWSIoTMQTTClient.configureMQTTOperationTimeout(5)  # 5 sec

# Connect and subscribe to AWS IoT
myAWSIoTMQTTClient.connect()

# myAWSIoTMQTTClient.subscribe(topic_name, 1, customCallback)
# time.sleep(2)

# Publish to the same topic in a loop forever
loopCount = 0
while True:
    message = {}
    message['message'] = "Hola"
    message['sequence'] = loopCount
    messageJson = json.dumps(message)
    myAWSIoTMQTTClient.publish(topic_name, messageJson, 1)
    print('Published topic %s: %s\n' % (topic_name, messageJson))
    loopCount += 1
    time.sleep(1)



from AWSIoTPythonSDK.MQTTLib import AWSIoTMQTTClient
import time
import json

AllowedActions = ['both', 'publish', 'subscribe']

# Custom MQTT message callback


def customCallback(client, userdata, message):
    print("Received a new message: ")
    print(message.payload)
    print("from topic: ")
    print(message.topic)
    print("--------------\n\n")


host = "af9dalmtltyi1-ats.iot.eu-west-1.amazonaws.com"
rootCAPath = "/home/jorge/tfg/aws-iot-tfg/certs/AmazonRootCA1.pem"
certificatePath = "/home/jorge/tfg/aws-iot-tfg/certs/cert.crt"
privateKeyPath = "/home/jorge/tfg/aws-iot-tfg/certs/private_key.pem"
port = 443
clientId = "poc-iot-client"
topic = "poc-iot-topic"

# Init AWSIoTMQTTClient
myAWSIoTMQTTClient = None
myAWSIoTMQTTClient = AWSIoTMQTTClient(clientId)
myAWSIoTMQTTClient.configureEndpoint(host, port)
myAWSIoTMQTTClient.configureCredentials(
    rootCAPath, privateKeyPath, certificatePath)

# AWSIoTMQTTClient connection configuration
myAWSIoTMQTTClient.configureAutoReconnectBackoffTime(1, 32, 20)
# Infinite offline Publish queueing
myAWSIoTMQTTClient.configureOfflinePublishQueueing(-1)
myAWSIoTMQTTClient.configureDrainingFrequency(2)  # Draining: 2 Hz
myAWSIoTMQTTClient.configureConnectDisconnectTimeout(10)  # 10 sec
myAWSIoTMQTTClient.configureMQTTOperationTimeout(5)  # 5 sec

# Connect and subscribe to AWS IoT
myAWSIoTMQTTClient.connect()

# myAWSIoTMQTTClient.subscribe(topic, 1, customCallback)
# time.sleep(2)

# Publish to the same topic in a loop forever
loopCount = 0
while True:
    message = {}
    message['message'] = "Hola"
    message['sequence'] = loopCount
    messageJson = json.dumps(message)
    myAWSIoTMQTTClient.publish(topic, messageJson, 1)
    print('Published topic %s: %s\n' % (topic, messageJson))
    loopCount += 1
    time.sleep(1)

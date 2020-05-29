python3 subscriber_simulator.py \
--thing-name sensor1 \
--client-id poc-iot-client-1 \
--topic-name poc-iot-topic-receptor-1 \
--iot-endpoint af9dalmtltyi1.iot.eu-west-1.amazonaws.com \
--root-ca-path ../certs/AmazonRootCA1.pem \
--certificate-path ../certs/sensor1/cert.crt \
--private-key-path ../certs/sensor1/private_key.pem

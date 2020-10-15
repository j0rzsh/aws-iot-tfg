python3 iot_thing_simulator.py \
--thing-name sensor1 \
--client-id poc-iot-client-1 \
--topic-name poc-iot-topic-1 \
--iot-endpoint <IOT-ENDPOINT> \
--root-ca-path certs/AmazonRootCA1.pem \
--certificate-path certs/sensor1/cert.crt \
--private-key-path certs/sensor1/private_key.pem &

python3 iot_thing_simulator.py \
--thing-name sensor2 \
--client-id poc-iot-client-2 \
--topic-name poc-iot-topic-2 \
--iot-endpoint <IOT-ENDPOINT> \
--root-ca-path certs/AmazonRootCA1.pem \
--certificate-path certs/sensor2/cert.crt \
--private-key-path certs/sensor2/private_key.pem &

python3 iot_thing_simulator.py \
--thing-name sensor3 \
--client-id poc-iot-client-3 \
--topic-name poc-iot-topic-3 \
--iot-endpoint <IOT-ENDPOINT> \
--root-ca-path certs/AmazonRootCA1.pem \
--certificate-path certs/sensor3/cert.crt \
--private-key-path certs/sensor3/private_key.pem &

python3 iot_thing_simulator.py \
--thing-name sensor4 \
--client-id poc-iot-client-4 \
--topic-name poc-iot-topic-4 \
--iot-endpoint <IOT-ENDPOINT> \
--root-ca-path certs/AmazonRootCA1.pem \
--certificate-path certs/sensor4/cert.crt \
--private-key-path certs/sensor4/private_key.pem &

while true; do :; done & kill -STOP $! && wait $!

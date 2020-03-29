import subprocess
import json
import os

sensors = ["sensor1", "sensor2", "sensor3", "sensor4"]

p = subprocess.check_output(["terraform", "output", "-json"], cwd="../.")
json = json.loads(p.decode("utf-8"))

if not os.path.isdir("../certs"):
    os.mkdir("../certs", mode=0o755)
    os.chmod("../certs", mode=0o755)

if not os.path.isdir("../config"):
    os.mkdir("../config", mode=0o755)
    os.chmod("../config", mode=0o755)

for sensor in sensors:
    if not os.path.isdir("../certs/" + sensor):
        os.mkdir("../certs/" + sensor, mode=0o755)
        os.chmod("../certs/" + sensor, mode=0o755)

    cert = json["iot_certificate_pem_" + sensor]["value"]
    private_key = json["iot_certificate_private_key_" + sensor]["value"]
    public_key = json["iot_certificate_public_key_" + sensor]["value"]

    fcert = open("../certs/" + sensor + "/cert.crt", "w")
    fcert.write(cert)
    fcert.close()

    fpriv = open("../certs/" + sensor + "/private_key.pem", "w")
    fpriv.write(private_key)
    fpriv.close()

    fpub = open("../certs/" + sensor + "/public_key.pem", "w")
    fpub.write(public_key)
    fpub.close()

elasticsearch_domain = json["elastisearch_domain_endpoint"]["value"]
iot_endpoint = json["iot_endpoint"]["value"]

fes = open("../config/elasticsearch_domain", "w")
fes.write(elasticsearch_domain)
fes.close()

fiotend = open("../config/iot_endpoint", "w")
fiotend.write(iot_endpoint)
fiotend.close()

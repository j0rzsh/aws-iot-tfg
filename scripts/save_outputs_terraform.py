import subprocess
import json
import os

if not os.path.isdir("../certs"):
    os.mkdir("../certs", mode=0o755)
    os.chmod("../certs", mode=0o755)

if not os.path.isdir("../config"):
    os.mkdir("../config", mode=0o755)
    os.chmod("../config", mode=0o755)

p = subprocess.check_output(["terraform", "output", "-json"], cwd="../.")
json = json.loads(p.decode("utf-8"))  # print(type(p.decode("utf-8")))

cert = json["iot_certificate_pem"]["value"]
private_key = json["iot_certificate_private_key"]["value"]
public_key = json["iot_certificate_public_key"]["value"]
elasticsearch_domain = json["elastisearch_domain_endpoint"]["value"]

fcert = open('../certs/cert.crt', 'w')
fcert.write(cert)
fcert.close()

fpriv = open('../certs/private_key.pem', 'w')
fpriv.write(private_key)
fpriv.close()

fpub = open('../certs/public_key.pem', 'w')
fpub.write(public_key)
fpub.close()

fes = open('../config/elasticsearch_domain', 'w')
fes.write(elasticsearch_domain)
fes.close()

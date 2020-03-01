import subprocess
import json

p = subprocess.check_output(["terraform", "output", "-json"], cwd="../.")
json = json.loads(p.decode("utf-8"))  # print(type(p.decode("utf-8")))

cert = json["iot_certificate_pem"]["value"]
private_key = json["iot_certificate_private_key"]["value"]
public_key = json["iot_certificate_public_key"]["value"]

fcert = open('../certs/cert.crt', 'w')
fcert.write(cert)
fcert.close()

fpriv = open('../certs/private_key.pem', 'w')
fpriv.write(private_key)
fpriv.close()

fpub = open('../certs/public_key.pem', 'w')
fpub.write(public_key)
fpub.close()

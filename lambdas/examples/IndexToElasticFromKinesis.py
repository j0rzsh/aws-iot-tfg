import boto3
import json
from botocore.vendored import requests
#import requests
#from requests_aws4auth import AWS4Auth

region = 'eu-west-1'
service = 'es'
credentials = boto3.Session().get_credentials()
#awsauth = AWS4Auth(credentials.access_key, credentials.secret_key, region, service, session_token=credentials.token)

# the Amazon ES domain, including https://
host = 'https://search-domain-elastic-dof4qqwzg3nblc57do7s3bcku4.us-east-1.es.amazonaws.com'

headers = {"Content-Type": "application/json"}


def lambda_handler(event, context):
    for record in event['Records']:
        # Kinesis data is base64-encoded, so decode here
        jsonD = base64.b64decode(record['kinesis']['data'])
        parsed_jsonD = json.loads(jsonD)

    # Save id and date to use it for indexing
    index = parsed_jsonD['cacharro']
    type = '_doc'
    fecha = parsed_jsonD['fecha']
    url = host + '/' + index + '/' + '_doc' + '/' + str(fecha)

    message = parsed_jsonD['message']

    # Create the JSON document
    document = {"Ocupacion": str(message)}
    test = {"director": "Jorge", "genre": ["Comedy"], "year": 1996, "actor": [
        "Sarah Jessica Parker"], "title": "Me tiene el elastic cansao ya!"}
    # Index the document
    try:
        r = requests.put(url, json=document, headers=headers)
    except requests.exceptions.RequestException as e:
        print e
        sys.exit(1)
    return 'Good'

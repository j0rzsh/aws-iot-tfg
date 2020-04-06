import boto3
import os
from datetime import datetime
from elasticsearch import Elasticsearch, RequestsHttpConnection
from requests_aws4auth import AWS4Auth

INDEX_NAME = os.environ["es_index"]

service = "es"
region = "eu-west-1"
credentials = boto3.Session().get_credentials()
awsauth = AWS4Auth(credentials.access_key, credentials.secret_key,
                   region, service, session_token=credentials.token)


def init_es():
    host = os.environ["es_host"]
    es = Elasticsearch(
        hosts=[{"host": host, "port": 443}],
        http_auth=awsauth,
        use_ssl=True,
        verify_certs=True,
        connection_class=RequestsHttpConnection
    )
    return es


def index_to_es(client, index, doc_type,
                id, body, request_timeout):
    # TO-DO: handle retries??
    resp = client.index(
        index=index,
        doc_type=doc_type,
        id=id,
        body=body,
        request_timeout=request_timeout
    )
    return resp


def lambda_handler(event, context):
    es = init_es()
    try:
        timestamp = datetime.now().strftime("%Y-%m-%dT%H:%M:%S")
        thing_name = event["thing_name"]
        event.pop("thing_name")
        event["air_temperature"]
        event["air_humidity"]
        event["soil_temperature"]
        event["soil_moisture"]
        event["atmospheric_pressure"]
    except Exception:
        pass

    resp = index_to_es(client=es, index=INDEX_NAME, doc_type=thing_name,
                       id=timestamp, body=event, request_timeout=45)

    return resp

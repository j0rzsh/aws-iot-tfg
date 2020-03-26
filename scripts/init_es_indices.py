from elasticsearch import Elasticsearch, RequestsHttpConnection
from requests_aws4auth import AWS4Auth
import boto3


with open("../config/elasticsearch_indices") as indices_file:
    indices = [line.strip() for line in indices_file]

with open("../config/elastichsearch_domain") as es_domain_file:
    host = es_domain_file.readline()

service = "es"
region = "eu-west-1"
credentials = boto3.Session().get_credentials()
awsauth = AWS4Auth(credentials.access_key, credentials.secret_key,
                   region, service, session_token=credentials.token)

es = Elasticsearch(
    hosts=[{"host": host, "port": 443}],
    http_auth=awsauth,
    use_ssl=True,
    verify_certs=True,
    connection_class=RequestsHttpConnection
)

for index in indices:
    es.indices.create(index=index, ignore=400)

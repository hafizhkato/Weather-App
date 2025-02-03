import json
import requests
import os
import boto3
from datetime import datetime
import time

dynamodb = boto3.resource("dynamodb")
table = dynamodb.Table("LocationData")


def lambda_handler(event, context):
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    query_params = event.get("queryStringParameters", {})
    location = query_params.get("location", "London")

    item = {
            'location': location,
            'timestamp': timestamp
        }

    table.put_item(Item=item)

    api_key = os.getenv("OPENWEATHERMAP_API_KEY")
    if not api_key:
        return {"statusCode": 500, "body": json.dumps({"error": "API key not set"})}

    url = f"https://api.openweathermap.org/data/2.5/weather?q={location}&appid={api_key}&units=metric"
    response = requests.get(url)

    return {"statusCode": response.status_code, "body": response.text}

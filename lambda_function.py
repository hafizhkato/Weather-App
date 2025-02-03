import json
import requests
import os
import boto3
from datetime import datetime
import time

dynamodb = boto3.resource("dynamodb")
table = dynamodb.Table("LocationData")


def lambda_handler(event, context):
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S") #get time right now
    query_params = event.get("queryStringParameters", {})
    location = query_params.get("location", "London") #get the location from API query

# prepare for table attribute in DynamoDb
    item = { 
            'location': location,
            'timestamp': timestamp
        }

    table.put_item(Item=item)
    #get your API_Key from environment variables
    api_key = os.getenv("OPENWEATHERMAP_API_KEY")
    if not api_key:
        return {"statusCode": 500, "body": json.dumps({"error": "API key not set"})}# In case did not set API key in environment variable

    #fetch data from OpenWeatherMap
    url = f"https://api.openweathermap.org/data/2.5/weather?q={location}&appid={api_key}&units=metric"
    response = requests.get(url)

    return {"statusCode": response.status_code, "body": response.text}

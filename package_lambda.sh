#!/bin/bash

# Clean up old package
rm -rf package lambda.zip

# Create package directory
mkdir package

# Install dependencies in the package folder
pip install -r requirements.txt -t package/

# Copy the Lambda function file
cp lambda_function.py package/

# Zip the package
cd package
zip -r ../lambda.zip .

# Go back to the project root
cd ..
Weather App - Infrastructure as Code with Terraform

Overview

This project is a Weather Application that fetches real-time weather data and displays it in a user-friendly interface. While the application itself serves a practical purpose, the real goal of this project is to manage its cloud infrastructure using Terraform, rather than manually configuring resources via the AWS Management Console.

In this project we will be using Amazon S3 as a hosting site since we will be using static website, API Gateway to connect Frontend and Backend, AWS Lambda to fetch the weather, IAM to setup role and DynamoDb for database. 

I also seperate the .tf file according to AWS Service. So if you want to see s3 bucket configuration using terraform, you can look at s3-bucket.tf

So here is the .tf file for each service

S3 ---> s3-bucket.tf

AWS Lambda --> lambda.tf

Amazon API Gateway --> api-gateway.tf

IAM --> iam-role.tf

Amazon DynamoDb --> dynamoDb.tf

The frontend of this project is store under source folder. There is index.html,styles.css and scripts.js



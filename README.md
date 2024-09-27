# Full-Stack Development Best Practices in AWS
This repository contains best practices for full-stack development in AWS using Amazon ECR connected with GitHub workflows. It is designed to run Docker containers on EC2.

## Running Locally
To run the application locally, use the following command:
```
docker-compose up -d --build
```

## Running on EC2
To run the application on an EC2 instance, update the `run-containers(for ec2).sh` file and run it as a script. This requires proper AWS configuration settings. Then, run the script.
```
./run-containers.sh
```

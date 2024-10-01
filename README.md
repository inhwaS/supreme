# Secure Your Website: Best Practices for AWS Deployment
This repository contains best practices for full-stack development in AWS using Amazon ECR connected with GitHub workflows. It is designed to run Docker containers on EC2. I created detailed explanation about this repsitory [here](https://dev.to/_ed05fd08c4eda7feb1f56/secure-your-website-best-practices-for-aws-deployment-5c48).
Also, you can see the running containers on https://www.dragonai.live

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

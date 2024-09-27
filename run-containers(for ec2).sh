#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Variables
AWS_REGION="us-east-1"
AWS_ACCOUNT_ID="" # need to update
DOCKER_COMPOSE_FILE="./docker-compose.yml"
ECR_URL="$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com"
AWS_CLI_PATH="/usr/local/bin/aws"

# Define the Docker images to pull from ECR
IMAGES=(
    "supreme-backend"
    "supreme-frontend:latest"
    "supreme-nginx"
)

# Update the system packages
sudo apt-get update -y

# Install Docker if it's not installed
if ! command -v docker &> /dev/null
then
    echo "Docker not found, installing Docker..."
    sudo apt-get install -y docker.io
    sudo systemctl start docker
    sudo systemctl enable docker
    sudo usermod -a -G docker ubuntu
    echo "Docker installed and started."
fi

# Install Docker Compose if it's not installed
if ! command -v docker-compose &> /dev/null
then
    echo "Docker Compose not found, installing Docker Compose..."
    sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    echo "Docker Compose installed."
fi

# Install AWS CLI if not installed
if ! command -v aws &> /dev/null
then
    echo "AWS CLI not found, installing AWS CLI..."
    sudo apt-get install -y unzip curl
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install
    echo "AWS CLI installed."
fi

# Authenticate Docker with Amazon ECR
echo "Logging into AWS ECR..."
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ECR_URL

# Pull the required Docker images from ECR
for IMAGE in "${IMAGES[@]}"; do
  echo "Pulling image: $ECR_URL/$IMAGE"
  docker pull "$ECR_URL/$IMAGE"
done

# Run Docker Compose to start the containers
echo "Running Docker Compose..."
docker-compose up -d

echo "Containers are up and running."

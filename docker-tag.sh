# Variables
AWS_REGION="us-east-1"  # Replace with your actual AWS region
ECR_REPO_NAME_BACKEND="supreme-backend"
ECR_REPO_NAME_FRONTEND="supreme-frontend"
ECR_REPO_NAME_NGINX="supreme-nginx"
IMAGE_TAG="latest"  # You can change this to a specific version/tag

# Get the account ID
ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)

# Full ECR repository URIs
ECR_URI_BACKEND="${ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO_NAME_BACKEND}"
ECR_URI_FRONTEND="${ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO_NAME_FRONTEND}"
ECR_URI_NGINX="${ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO_NAME_NGINX}"

# Create ECR repositories if they do not exist
# aws ecr create-repository --repository-name ${ECR_REPO_NAME_BACKEND} --region ${AWS_REGION} || echo "Repository ${ECR_REPO_NAME_BACKEND} already exists."
# aws ecr create-repository --repository-name ${ECR_REPO_NAME_FRONTEND} --region ${AWS_REGION} || echo "Repository ${ECR_REPO_NAME_FRONTEND} already exists."
# aws ecr create-repository --repository-name ${ECR_REPO_NAME_NGINX} --region ${AWS_REGION} || echo "Repository ${ECR_REPO_NAME_NGINX} already exists."

# Login to ECR
aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${ECR_URI_BACKEND}

# Build images for both architectures
echo "Building multi-architecture Docker images..."

# Use --platform to build for both architectures
docker buildx build --platform linux/amd64,linux/arm64 -t ${ECR_URI_BACKEND}:${IMAGE_TAG} --push ./demo
docker buildx build --platform linux/amd64,linux/arm64 -t ${ECR_URI_FRONTEND}:${IMAGE_TAG} --push ./front
docker buildx build --platform linux/amd64,linux/arm64 -t ${ECR_URI_NGINX}:${IMAGE_TAG} --push .

echo "Pushed multi-architecture images to ECR."

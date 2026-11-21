
#!/bin/bash

set -e

REGION="us-east-1"
ACCOUNT_ID="731802382432"
REPOSITORY="ai-model-api"

IMAGE_URI="$ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/$REPOSITORY:latest"

echo "Logging in to Amazon ECR"

aws ecr get-login-password --region "$REGION" | \
docker login --username AWS --password-stdin \
"$ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com"

echo "Pulling updated AI model image"

docker pull "$IMAGE_URI"

echo "Stopping previous container"

docker rm -f ai-model-api || true

echo "Starting updated AI API"

docker run -d \
  --name ai-model-api \
  --restart unless-stopped \
  -p 8000:8000 \
  "$IMAGE_URI"

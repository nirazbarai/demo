#!/bin/bash

# Set variables
APP_NAME="springboot-app"
IMAGE_NAME="springboot-app"
CONTAINER_NAME="springboot-app"
PORT="8020"
DOCKERFILE="Dockerfile"

# Check for existing container with the same name and stop it
echo "Checking for existing container..."

# Check if a container with the specified name exists and is running
if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
    echo "Stopping and removing the existing container ($CONTAINER_NAME)..."
    docker stop $CONTAINER_NAME
    docker rm $CONTAINER_NAME
fi

# Optionally, remove the container even if it's not running (if you want to cleanup all containers)
if [ "$(docker ps -aq -f name=$CONTAINER_NAME)" ]; then
    echo "Removing the container ($CONTAINER_NAME) even if it's not running..."
    docker rm $CONTAINER_NAME
fi

# Build the Docker image
echo "Building the Docker image..."
docker build -t $IMAGE_NAME -f $DOCKERFILE .

# Run the Docker container
echo "Running the Docker container..."
docker run -d --name $CONTAINER_NAME -p $PORT:8080 $IMAGE_NAME

# Verify deployment
if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
    echo "Deployment successful! Application is running on port $PORT."
else
    echo "Deployment failed. Check the Docker logs for details."
fi


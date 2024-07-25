#!/bin/bash

# Function to delete a container if it exists
delete_container() {
  CONTAINER_NAME=$1
  if [ $(docker ps -a -q -f name=$CONTAINER_NAME) ]; then
    echo "Deleting existing container: $CONTAINER_NAME"
    docker rm -f $CONTAINER_NAME
  else
    echo "Container $CONTAINER_NAME does not exist. Skipping deletion."
  fi
}

# Delete node1 and node2 if they exist
delete_container "node1"
delete_container "node2"

# Run the Docker containers for Node1 and Node2
echo "Running node1 container..."
docker run --name node1 --privileged -d ipsec-node1

echo "Running node2 container..."
docker run --name node2 --privileged -d ipsec-node2

echo "Containers node1 and node2 are up and running."


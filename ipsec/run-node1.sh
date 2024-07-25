#!/bin/bash


docker build -t ipsec-node1 -f Dockerfile.node1 .

# Check if the Docker network 'ipsec-network' exists
if ! docker network ls --format '{{.Name}}' | grep -q '^ipsec-network$'; then
  # Create the Docker network if it doesn't exist
  docker network create --driver bridge ipsec-network
  echo "Docker network 'ipsec-network' created."
else
  echo "Docker network 'ipsec-network' already exists."
fi

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

delete_container "node1"

# Run the Docker containers for Node1 and Node2
echo "Running node1 container..."
docker run --name node1 --network ipsec-network --privileged -p 500:500/udp -p 4500:4500/udp -d ipsec-node1


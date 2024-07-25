#!/bin/bash
# Bring up the IP interfaces
ip addr add 10.0.0.2/24 dev eth0
ip link set dev eth0 up

# Start the StrongSwan service
ipsec start

# Keep the container running
tail -f /dev/null


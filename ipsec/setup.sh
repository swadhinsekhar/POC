#!/bin/bash
#

# sudo apt-get install strongswan

## cleanup
sudo ip netns delete ns1
sudo ip netns delete ns2
sudo ip link delete veth1
sudo ip link delete veth2


sudo ip netns add ns1
sudo ip netns add ns2

sudo ip link add veth1 type veth peer name veth2
sudo ip link set veth1 netns ns1
sudo ip link set veth2 netns ns2


sudo ip netns exec ns1 ip addr add 10.0.0.1/24 dev veth1
sudo ip netns exec ns2 ip addr add 10.0.0.2/24 dev veth2
sudo ip netns exec ns1 ip link set veth1 up
sudo ip netns exec ns2 ip link set veth2 up

## STOP IPSEC
# Stop StrongSwan Services, if running
sudo ip netns exec ns1 ipsec stop
sudo ip netns exec ns2 ipsec stop

# Verify that no charon or starter processes are running:
sudo ip netns exec ns1 pkill charon
sudo ip netns exec ns2 pkill charon
sudo ip netns exec ns1 pkill starter
sudo ip netns exec ns2 pkill starter


# Start StrongSwan Services
sudo ip netns exec ns1 ipsec start
sudo ip netns exec ns2 ipsec start

# Check the IPSec Status:
sudo ip netns exec ns1 ipsec statusall
sudo ip netns exec ns2 ipsec statusall



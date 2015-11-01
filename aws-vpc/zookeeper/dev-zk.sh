#!/bin/bash

DOCKER_IMAGE=`curl -sSL http://infradash.github.io/public/dash/latest/DOCKER`
CONFIG_URL="http://qoriolabs.github.io/public/aws-vpc/zookeeper/dev-zk.terraform"
HOSTNAME=`/sbin/ifconfig eth0 | grep 'inet addr' | cut -d: -f2 | awk '{print $$1}'`

echo "Starting zookeeper ensemble member $HOSTNAME @ Image=$DOCKER_IMAGE"
docker run -d -p 8080:8080 -p 2181:2181 -p 2888:2888 -p 3888:3888 --name zk -e DASH_IP=$HOSTNAME -e DASH_CONFIG_URL=$CONFIG_URL $DOCKER_IMAGE




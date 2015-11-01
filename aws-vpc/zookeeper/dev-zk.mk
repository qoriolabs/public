
DOCKER_IMAGE:="infradash/zookeeper:119"
CONFIG_URL:="http://qoriolabs.github.io/public/aws-vpc/zookeeper/dev-zk.terraform"
HOST_IP:=`/sbin/ifconfig eth0 | grep 'inet addr' | cut -d: -f2 | awk '{print $$1}'`

all: run-zk

start:
	echo "Starting zookeeper ensemble member $(HOST_IP) @ Image=$(DOCKER_IMAGE)"
	-docker stop zk
	-docker rm zk

run-zk: start
	docker run -d --name zk \
	-p 8080:8080 -p 2181:2181 -p 2888:2888 -p 3888:3888 \
	-e DASH_IP=$(HOST_IP) \
	-e DASH_NAME=$(HOST_IP) \
	-e DASH_CONFIG_URL=$(CONFIG_URL) \
	$(DOCKER_IMAGE)





DOCKER_IMAGE:="infradash/zookeeper:135"
CONFIG_URL:="http://qoriolabs.github.io/public/aws-vpc/zookeeper/local-zk.terraform"
HOST_IP:="192.168.99.100"
PWD:=`pwd`

all: run-zk

start:
	echo "Starting zookeeper ensemble member $(HOST_IP) @ Image=$(DOCKER_IMAGE)"
	-docker stop zk
	-docker rm zk

myid:
	echo $(MYID) > $(PWD)/myid
	echo "Written $(MYID) to myid"

run-zk: start myid
	docker run -d --name zk \
	-v $(PWD)/myid:/var/zookeeper/myid \
	-p 8080:8080 -p 2181:2181 -p 2888:2888 -p 3888:3888 \
	-e DASH_IP=$(HOST_IP) \
	-e DASH_NAME=$(HOST_IP) \
	-e DASH_CONFIG_URL=$(CONFIG_URL) \
	$(DOCKER_IMAGE)




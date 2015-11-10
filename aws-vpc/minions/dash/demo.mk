DOCKER_IMAGE=infradash/dash:release-1.3-82
CONFIG="http://qoriolabs.github.io/public/aws-vpc/minions/dash/demo.json"
HOST_IP=`/sbin/ifconfig eth0 | grep 'inet addr' | cut -d: -f2 | awk '{print $$1}'`
ZKHOSTS="zk01.qor.io:2181,zk02.qor.io:2181,zk03.qor.io:2181"
DASH_TAGS=appserver
NAME=dash

all: run-dash

start:
	echo "Running DASH for $(DASH_DOMAIN)"
	-docker stop dash
	-docker rm dash

run-dash: start
	echo "Starting up DASH image: $(DOCKER_IMAGE)"
	sudo docker run -d --name=$(NAME) \
	-e DASH_DOMAIN=$(DASH_DOMAIN) \
	-e DASH_TAGS=$(DASH_TAGS) \
	-e DASH_HOST=$(HOST_IP) \
	-e DASH_NAME=$(NAME) \
	-e DASH_ZK_HOSTS=$(ZKHOSTS) \
	-e DASH_DOCKER_PORT=unix:///var/run/docker.sock -v /var/run/docker.sock:/var/run/docker.sock \
	-p 25657:25657 -p 25658:25658 $(DOCKER_IMAGE) \
	-status_topic=mqtt://iot.eclipse.org:1883/demo \
	-config_url=$(CONFIG) -timeout=30s -enable_ui=true agent

no-config: start
	echo "Starting up DASH image: $(DOCKER_IMAGE)"
	sudo docker run -d --name=$(NAME) \
	-e DASH_DOMAIN=$(DASH_DOMAIN) \
	-e DASH_TAGS=$(DASH_TAGS) \
	-e DASH_HOST=$(HOST_IP) \
	-e DASH_NAME=$(NAME) \
	-e DASH_ZK_HOSTS=$(ZKHOSTS) \
	-e DASH_DOCKER_PORT=unix:///var/run/docker.sock -v /var/run/docker.sock:/var/run/docker.sock \
	-p 25657:25657 -p 25658:25658 $(DOCKER_IMAGE) \
	-status_topic=mqtt://iot.eclipse.org:1883/qoriolabs.com/demo \
	-timeout=30s -enable_ui=true agent

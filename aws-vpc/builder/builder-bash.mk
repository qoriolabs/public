DOCKER_IMAGE    ?= infradash/builder:127
DASH_CONFIG_URL ?= http://qoriolabs.github.io/public/aws-vpc/builder/bash.json
DASH_ZK_HOSTS   ?= zk01.qor.io:2181,zk02.qor.io:2181,zk03.qor.io:2181
DASH_NAME       ?= builder
HOSTIP          ?= `/sbin/ifconfig eth0 | grep 'inet addr' | cut -d: -f2 | awk '{print $$1}'`
CONTAINER_NAME  ?= builder

all: run-builder

start:
	echo "Running BUILDER for $(DASH_DOMAIN)"
	-docker stop $(CONTAINER_NAME)
	-docker rm $(CONTAINER_NAME)

# Also mount local docker so that it has access to docker daemon for building images, etc.
run-builder: start
	echo "Starting up BUILDER image: $(DOCKER_IMAGE)"
	docker run -d -P --name $(CONTAINER_NAME) \
	-v /var/run/docker.sock:/var/run/docker.sock -v `which docker`:/bin/docker \
	-e DASH_DOMAIN=$(DASH_DOMAIN) \
	-e DASH_SERVICE=$(DASH_SERVICE) \
	-e DASH_VERSION=$(DASH_VERSION) \
	-e DASH_NAME=$(DASH_NAME) \
	-e DASH_ZK_HOSTS=$(DASH_ZK_HOSTS) \
	-e DASH_CONFIG_URL=$(DASH_CONFIG_URL) \
	$(DOCKER_IMAGE) 


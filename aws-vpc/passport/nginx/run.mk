DOCKER_IMAGE=infradash/nginx:85
DASH_DOMAIN=account.qor.io
DASH_SERVICE=passport-nginx
CONFIG=http://qoriolabs.github.io/public/aws-vpc/passport/nginx/dash.json
HOS_IP=`/sbin/ifconfig eth0 | grep 'inet addr' | cut -d: -f2 | awk '{print $$1}'`
ZKHOSTS="zk01.qor.io:2181,zk02.qor.io:2181,zk03.qor.io:2181"
DASH_BIN="http://infradash.github.io/public/dash/latest/bin/dash"

all: run-nginx register cleanup

start:
	echo "Running NGINX for $(DASH_DOMAIN)"
	-docker stop passport-nginx
	-docker rm passport-nginx

get-dash: start
	wget $(DASH_BIN)
	chmod a+x dash

register: get-dash
	DASH_ZK_HOSTS=$(ZKHOSTS) \
	./dash --logtostderr --commit \
	--writepath=/$(DASH_DOMAIN)/$(DASH_SERVICE) --writevalue=$(HOST_IP):443 \
	registry

run-nginx: start
	echo "Starting up NGINX image: $(DOCKER_IMAGE)"
	docker run -d --name passport-nginx \
	-e DASH_ZK_HOSTS=$(ZKHOSTS) \
	-e DASH_DOMAIN=$(DASH_DOMAIN) \
	-e DASH_SERVICE=$(DASH_SERVICE) \
	-e DASH_CONFIG_URL=$(CONFIG) \
	-p 443:443 \
	$(DOCKER_IMAGE)

cleanup:
	rm dash
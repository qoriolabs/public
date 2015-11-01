Zookeeper Install and Setup
===========================

This is the example scripts and configuration for auto-configuring a zookeeper ensemble.
Steps to set up a new ensemble:

1. Provision machines
    + Docker must be installed
    + Make sure ports 8080, 2181, 2888, 3888 are open
    + Use magnetic disk.  Zookeeper is optimized for magnetic disk than SSD, which has higher write latency.
2. Create a file like `dev-zk.terraform`.  List the IP addresses of the machines in the ensemble.
3. See the script `dev-zk.sh` for example.  It basically determines the IP address of the host and pass appropriate data to the docker command
4. Start the containers by `curl -sSL http://qoriolabs.github.io/public/aws-vpc/zookeeper/dev-zk.sh | sh -`

For example, we have hosts `10.0.16.50`, `10.0.32.50`, `10.0.48.50`

```
ssh 10.0.16.50 "curl -sSL http://qoriolabs.github.io/public/aws-vpc/zookeeper/dev-zk.mk | MYID=1 make -f -"
ssh 10.0.32.50 "curl -sSL http://qoriolabs.github.io/public/aws-vpc/zookeeper/dev-zk.mk | MYID=2 make -f -"
ssh 10.0.48.50 "curl -sSL http://qoriolabs.github.io/public/aws-vpc/zookeeper/dev-zk.mk | MYID=3 make -f -"
```

To check, log at the logs:
```
ssh 10.0.16.50 docker logs -f zk
ssh 10.0.32.50 docker logs -f zk
ssh 10.0.48.50 docker logs -f zk
```


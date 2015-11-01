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

TODO
====
+ Note that `/var/zookeeper/myid` must be generated and mounted to the container.  This is accomplished in the makefile script itself.  A better way is to have a server that looks at the configuration (`.terraform` file) and generate the ssh commands on the fly.
+ 

SSH Setup
=========
1. Make sure you have the pem file for ssh to the instances.
2. Compile `connect.c` proxy (see the `ssh` directory)
3. Add the following to the config
```
####################################
Host aws.qoriolabs.com
Hostname bastion.qoriolabs.com
User ubuntu
IdentityFile ~/.ssh/id_aws_qoriolabs_com_ops
DynamicForward 7782
#-----------------------------------
Host *.qor.io
User ubuntu
IdentityFile ~/.ssh/id_aws_qoriolabs_com_ops
ProxyCommand connect -S localhost:7782 %h %p
#-----------------------------------
Host 10.0.*
User ubuntu
IdentityFile ~/.ssh/id_aws_qoriolabs_com_ops
ProxyCommand connect -S localhost:7782 %h %p
####################################
```
Then run 
```
ssh -L 10080:zk01.qor.io:8080 -L 11080:10.0.16.50:8080 aws.qoriolabs.com
```
This for example maps the local port 11080 to the remote port 8080 which Exhibitior listens on.
To see the Exhibitor page, go to http://localhost:11080/exhibitor/v1/ui/index.html


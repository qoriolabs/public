SSH Tunnel / Proxy
==================

This is useful for connecting to private network in a VPC over a bastion server.

https://www.bartbusschots.ie/s/2005/12/07/ssh-via-a-socks-proxy-on-os-x-with-connectc/

Steps
-----

1. Compile connect.c:
```
gcc connect.c -o connect -lresolv
sudo cp connect /usr/local/bin
```

2. Edit your `~/.ssh/config` to add sections like:

```
Host *
ServerAliveInterval 120
TCPKeepAlive no 

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

3. Connect: Simply do this 
```
ssh ssh -L 10080:zk01.qor.io:8080 -L 11080:10.0.16.50:8080 aws.qoriolabs.com
```
This will, for example, do local port forwarding of 11080 to `10.0.6.16.50`.



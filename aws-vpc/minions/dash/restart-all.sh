#!/bin/bash

ssh 10.0.18.196 "curl -sSL http://qoriolabs.github.io/public/aws-vpc/minions/dash/demo.mk | DASH_DOMAIN=dev.qoriolabs.com make -f -"

ssh 10.0.43.214 "curl -sSL http://qoriolabs.github.io/public/aws-vpc/minions/dash/demo.mk | DASH_DOMAIN=integration.qoriolabs.com make -f -"

ssh 10.0.62.157 "curl -sSL http://qoriolabs.github.io/public/aws-vpc/minions/dash/demo.mk | DASH_DOMAIN=qa.qoriolabs.com make -f -"

ssh 10.0.21.67 "curl -sSL http://qoriolabs.github.io/public/aws-vpc/minions/dash/demo.mk | DASH_DOMAIN=staging.qoriolabs.com make -f -"

ssh 10.0.42.54 "curl -sSL http://qoriolabs.github.io/public/aws-vpc/minions/dash/demo.mk | DASH_DOMAIN=production.qoriolabs.com make -f -"
ssh 10.0.52.76 "curl -sSL http://qoriolabs.github.io/public/aws-vpc/minions/dash/demo.mk | DASH_DOMAIN=production.qoriolabs.com make -f -"
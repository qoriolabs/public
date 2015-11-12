#!/bin/bash

ssh 10.0.18.196 "docker run -d busybox /bin/sh -c \"while true; do echo `date`; sleep 60; done\""

ssh 10.0.43.214 "docker run -d busybox /bin/sh -c \"while true; do echo `date`; sleep 60; done\""

ssh 10.0.62.157 "docker run -d busybox /bin/sh -c \"while true; do echo `date`; sleep 60; done\""

ssh 10.0.21.67 "docker run -d busybox /bin/sh -c \"while true; do echo `date`; sleep 60; done\""

ssh 10.0.42.54 "docker run -d busybox /bin/sh -c \"while true; do echo `date`; sleep 60; done\""
ssh 10.0.52.76 "docker run -d busybox /bin/sh -c \"while true; do echo `date`; sleep 60; done\""


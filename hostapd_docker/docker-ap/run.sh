#!/bin/bash
docker stop autowlan
docker rm autowlan

sleep 5
docker run -i -t -e INTERFACE=wlan0 -e OUTGOINGS=eth0 --name autowlan --net host --privileged -d autowlan
sleep 2
docker logs autowlan

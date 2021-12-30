#!/bin/bash
docker stop pocketvpn-web
docker rm pocketvpn-web
docker rm $(docker ps -aq)
docker rmi apachetest
#docker system prune --all
docker builder prune

#!/bin/sh

pwd > currentdirectory
docker service rm captain-captain captain-nginx captain-certbot captain-registry
sleep 1s
docker secret rm captain-salt
docker build -t captain-debug -f dockerfile-captain.debug .
rm -rf /captain
mkdir /captain
docker run \
   -e "CAPTAIN_IS_DEBUG=1" \
   -v /var/run/docker.sock:/var/run/docker.sock \
   -v $(pwd):/usr/src/app captain-debug
sleep 2s
docker service logs captain-captain --follow

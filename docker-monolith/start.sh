#!/usr/bin/env bash
eval $(docker-machine env docker-host)

docker volume create reddit_db

docker network create hw-test-net

docker build -t andreyovs/post:latest ../src/post-py
docker build -t andreyovs/comment:latest ../src/comment
docker build -t andreyovs/ui:latest ../src/ui

echo "build compleeted"

docker run -d --network=hw-test-net --network-alias=post_db --network-alias=comment_db mongo:latest
docker run -d --network=hw-test-net -p --network-alias=post andreyovs/post:latest
docker run -d --network=hw-test-net -p 9292:9292 --network-alias=comment andreyovs/comment:latest
docker run -d --network=hw-test-net -p 9292:9292 --name=ui andreyovs/ui:latest

echo "run compleeted"
sleep 20

 curl http://ui:9292/new -F 'title=travis-test' -F  'link=https://travis-ci.org/'


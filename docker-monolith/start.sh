#!/usr/bin/env bash
eval $(docker-machine env docker-host)

docker volume create reddit_db

docker kill $(docker ps -q)

docker run -d --network=reddit --network-alias=post_db \
--network-alias=comment_db -v reddit_db:/data/db mongo:latest

docker run -d --network=reddit \
--network-alias=post andreyovs/post:latest

docker run -d --network=reddit \
--network-alias=comment andreyovs/comment:latest

docker run -d --network=reddit \
-p 9292:9292 andreyovs/ui:latest

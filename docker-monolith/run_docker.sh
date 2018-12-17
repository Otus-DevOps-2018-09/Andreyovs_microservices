#!/bin/bash
docker kill $(docker ps -q)
docker network create reddit

echo 'step 1'
docker run -d --network=reddit \
--network-alias=post_db_srv \
--network-alias=comment_db_srv -v reddit_db:/data/db mongo:latest

echo 'step 2'
docker run -d --network=reddit \
--network-alias=post_srv \
-e POST_DATABASE_HOST='post_db_srv' \
-e POST_DATABASE='posts_srv' \
andreyovs/post:latest

echo 'step 3'
docker run -d --network=reddit \
--network-alias=comment_srv \
-e COMMENT_DATABASE_HOST='comment_db_srv' \
-e COMMENT_DATABASE='comments_srv' \
andreyovs/comment:latest

echo 'step 4'
docker run -d --network=reddit \
-p 9292:9292\
-e POST_SERVICE_HOST='post_srv' \
-e COMMENT_SERVICE_HOST='comment_srv' \
andreyovs/ui:latest

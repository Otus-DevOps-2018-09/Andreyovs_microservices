#!/bin/bash
docker kill $(docker ps -q)
docker run -d --network=front_net -p 9292:9292 --name ui  andreyovs/ui:1.0
docker run -d --network=back_net --name comment  andreyovs/comment:1.0
docker run -d --network=back_net --name post  andreyovs/post:1.0
docker run -d --network=back_net --name mongo_db --network-alias=post_db --network-alias=comment_db mongo:latest
docker network connect front_net post
docker network connect front_net comment

# Andreyovs_microservices
Andreyovs microservices repository
HW 13
### Completed tasks

- :black_large_square: Installed Docker
- :black_large_square: Run first Docker `hello-world` container
- :black_large_square: Outputted result of `docker images` to `docker-monolith/docker-1.log`
- :large_orange_diamond: Described the difference of Docker image and container in `docker-monolith/docker-1.log`


HW 14

- :black_large_square: Created docker-host on GCP instance using `docker-machine` command
- :black_large_square: Created Dockerfile with configuration necessary to build `reddit` image
- :black_large_square: Pushed newly built Docker `reddit` image to Docker Hub as `andreyovs/otus-reddit:1.0`
- :large_orange_diamond: Created Packer template `docker.json` to build an image with preinstalled Docker CE
- :large_orange_diamond: Created Terraform configuration allowing to create several `app` instances (2 by default)
- :large_orange_diamond: Created Ansible playbooks to deploy `andreyovs/otus-reddit:1.0` application from Docker Hub to GCP instances

## HW 15. Docker images & microservices

## Completed tasks

- :black_large_square: Added three components to the `src` directory for Reddit application microservices
  - `post-py`
  - `comment`
  - `ui`
- :black_large_square: Created three Dockerfiles for the microservices and optimized Dockerfile commands to reduce image sizes
- :black_large_square: Created three Docker images with `docker build` command
- :black_large_square: Created bridged network `reddit`, assigned network aliases for containers, and launched containers in `reddit` network
- :large_orange_diamond: Stopped running containers and relaunched them with new network aliases and environment variables:

  #!/bin/bash
docker kill $(docker ps -q)

echo 'step 1'
docker run -d --network=reddit \
--network-alias=post_db_srv \
--network-alias=comment_db_srv -v reddit_db:/data/db mongo:latest

echo 'step 2'
docker run -d --network=reddit \
--network-alias=post_srv \
-e POST_DATABASE_HOST='post_db_srv' \
-e POST_DATABASE='posts_srv' \
andreyovs/post:1.0

echo 'step 3'
docker run -d --network=reddit \
--network-alias=comment_srv \
-e COMMENT_DATABASE_HOST='comment_db_srv' \
-e COMMENT_DATABASE='comments_srv' \
andreyovs/comment:1.0

echo 'step 4'
docker run -d --network=reddit \
-p 9292:9292 \
-e POST_SERVICE_HOST='post_srv' \
-e COMMENT_SERVICE_HOST='comment_srv' \
andreyovs/ui:1.0

- :large_orange_diamond: Created new images based on Linux Alpine  `post-py`, `comment`, and `ui` microservices. Files  stored ./docker-monolith/Dockerfile_*

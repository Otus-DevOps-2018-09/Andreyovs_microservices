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

### Completed tasks

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

## HW 16. Docker Lans

### Completed tasks

- :black_large_square: Made all tasks with network docker
- :black_large_square: Made all tasks with docker-compose

- :black_large_square: use command docker-compose with key -p, --project-name NAME Specify an alternate project name (default: directory name) or use  COMPOSE_PROJECT_NAME environment variable relates to the -p flag.
- :large_orange_diamond: docker-compose.override.yml.example created

## HW 17. GitLab Ci

- :black_large_square: Creted  Terraform , Ansible autodeploy scripts  GitLab CI gitlab-ci/infra/;
- :black_large_square: Configured Gitlab CI : project, runners etc ;

- :large_orange_diamond: created ansible script for generation Gitlab CI runner (gitlab-ci/infra/ansible/playbooks/runners.yml).
- :large_orange_diamond: made  Gitlab-CI integration with Slack

## HW 18. GitLab CI-2

- :black_large_square: extended pipeline dev,stage,prod;
- :black_large_square: configured dynamic enevtory for  review for all branches except master;


- :large_orange_diamond: in build task implemented build image reddit via docker hub
- :large_orange_diamond: created task on push branches to gitlab-ci exept master whre created docker-machine with reddit app image
- :large_orange_diamond: created task "kill branch review"

## HW 19 Monitoring-1

- :black_large_square: prometheus created docker-image


- :large_orange_diamond: created docker image mongodb_exporter (percona)
- :large_orange_diamond: Blackbox exporter used from prometheus
- :large_orange_diamond:  created Makefile script

## HW 20 Monitoring-2

- :black_large_square: created and mounted docker images: cAdvisor, Grafana, AlertManger
- :black_large_square:  created grafana dashboards
- :black_large_square:  configured alert integration

- :large_orange_diamond:  Makefile have been updated
- :large_orange_diamond: prometheus have been configured for monitoring native docker metrics
- :large_orange_diamond: email integration have been configured via alert manager

## HW 21 Tracing & Logging
- :black_large_square: Services have been updated for integration with fluentd, zipkin
- :black_large_square: docker-compose-logging.yml file have been created for deployment  (fluentd, ELK, zipkin)
- :black_large_square: configured fluentd, ELK


- :large_orange_diamond: Filter params  fluentd have been added parsing UI logs code

## HW 22 Kubernates
- :black_large_square: Manifest files have been created (ui, post, comment, mongo)
- :black_large_square: K8S  has been configured via hard-way
- :black_large_square: configured fluentd, ELK

- :large_orange_diamond: Ansible playbook has been created for k8s installation

## HW 23 Kubernates
- :black_large_square: Manifest files have been created (post, ui, comment, mongo), services and namespaces
- :black_large_square: Reddit app has been deployed on  minikube & GKE

- :large_orange_diamond: terraform deployment kubernates script has been created
- :large_orange_diamond: Manifest files have been created for kubernetes dashboard

## HW 24 Kubernates
- :black_large_square: Manifest files have been created (Ingress controller,TLS, Load Balancing, network policies, storages)

- :large_orange_diamond: has been created manifest (secret) with TLS-cert

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

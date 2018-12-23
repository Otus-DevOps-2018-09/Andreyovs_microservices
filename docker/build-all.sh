#/bin/bash
eval $(docker-machine env docker-host)
RED='\033[0;31m'
NC='\033[0m'
export USER_NAME=andreyovs

echo "${RED}build reddit"
for i  in ui post-py comment; do cd ../src/$i; bash docker_build.sh; cd -; done

echo "${RED}build prometheus"
docker build -t $USER_NAME/prometheus:latest ../monitoring/prometheus/
docker push $USER_NAME/prometheus:latest

echo "${RED}build mongod_exporter"
docker build -t $USER_NAME/mongodb_exporter:latest ../monitoring/mongod_exporter/
docker push $USER_NAME/mongodb_exporter:latest

echo "${RED}run docker-compose"
##docker-compose up -d

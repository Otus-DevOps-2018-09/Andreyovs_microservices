#/bin/bash
eval $(docker-machine env docker-host)
RED='\033[0;31m'
NC='\033[0m'
export USER_NAME=andreyovs

echo -e "${RED}build reddit${NC}"
for i  in ui post-py comment; do cd ../src/$i; bash docker_build.sh; cd -; done
docker push $USER_NAME/ui:latest
docker push $USER_NAME/post:latest
docker push $USER_NAME/comment:latest

echo -e "${RED}build prometheus${NC}"
docker build -t $USER_NAME/prometheus:latest ../monitoring/prometheus/
docker push $USER_NAME/prometheus:latest

echo "${RED}build mongod_exporter${NC}"
docker build -t $USER_NAME/mongodb_exporter:latest ../monitoring/mongod_exporter/
docker push $USER_NAME/mongodb_exporter:latest

echo "${RED}run docker-compose${NC}"
##docker-compose up -d

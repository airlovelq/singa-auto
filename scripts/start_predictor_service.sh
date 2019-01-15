usage()  {
  echo "Usage: $0 <service_name> <rafiki_service_id> <rafiki_service_type> <published_port>"
  exit 1
}

if [ $# -ne 4 ] ; then
    usage
fi

docker service create --name $1 \
  --network $DOCKER_NETWORK \
  -e POSTGRES_HOST=$POSTGRES_HOST \
  -e POSTGRES_PORT=$POSTGRES_PORT \
  -e POSTGRES_USER=$POSTGRES_USER \
  -e POSTGRES_DB=$POSTGRES_DB \
  -e POSTGRES_PASSWORD=$POSTGRES_PASSWORD \
  -e REDIS_HOST=$REDIS_HOST \
  -e REDIS_PORT=$REDIS_PORT \
  -e PREDICTOR_PORT=$PREDICTOR_PORT \
  -e RAFIKI_SERVICE_TYPE=$3 \
  -e RAFIKI_SERVICE_ID=$2 \
  -e LOGS_WORKDIR_PATH=$LOGS_WORKDIR_PATH \
  -e DATA_WORKDIR_PATH=$DATA_WORKDIR_PATH \
  -e LOGS_DOCKER_WORKDIR_PATH=$LOGS_DOCKER_WORKDIR_PATH \
  -e DATA_DOCKER_WORKDIR_PATH=$DATA_DOCKER_WORKDIR_PATH \
  -p $4:$PREDICTOR_PORT \
  --mount type=bind,src=$DATA_WORKDIR_PATH,dst=$DATA_DOCKER_WORKDIR_PATH \
  --mount type=bind,src=$LOGS_WORKDIR_PATH,dst=$LOGS_DOCKER_WORKDIR_PATH \
  $RAFIKI_IMAGE_PREDICTOR:$RAFIKI_VERSION

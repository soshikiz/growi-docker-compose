#!/bin/bash

BACKUP_PATH=$(pwd)/backup
MONGO_CONTAINER_NAME=growi_mongo_1
GROWI_CONTAINER_NAME=growi_app_1
NETWORK_CONTAINER_NAME=growi_default

sudo docker run -it --rm --link ${MONGO_CONTAINER_NAME} --network ${NETWORK_CONTAINER_NAME} --volume ${BACKUP_PATH}:/backup mongo:3.4 bash -c "mongorestore -v --host ${MONGO_CONTAINER_NAME} --db growi backup/growi"
sudo docker cp  ${BACKUP_PATH}/data ${GROWI_CONTAINER_NAME}:/data

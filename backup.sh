#!/bin/bash

TODAY=`date +"%Y%m%d"`
BACKUP_PATH=/home/growi/backup
MONGO_CONTAINER_NAME=growi_mongo_1
GROWI_CONTAINER_NAME=growi_app_1
NETWORK_CONTAINER_NAME=growi_default

sudo docker run -it --rm --link ${MONGO_CONTAINER_NAME} --network ${NETWORK_CONTAINER_NAME} --volume ${BACKUP_PATH}:/backup mongo:3.4 bash -c "mongodump --host ${MONGO_CONTAINER_NAME} --db growi --out /backup"
sudo docker cp ${GROWI_CONTAINER_NAME}:/data ${BACKUP_PATH}/data

sudo tar -C ${BACKUP_PATH} -zcvf ${BACKUP_PATH}/${TODAY}_growi_backup.tar.gz growi data

sudo rm -rf ${BACKUP_PATH}/growi
sudo rm -rf ${BACKUP_PATH}/data

find ${BACKUP_PATH} -name "*.tar" -mtime +7 -delete

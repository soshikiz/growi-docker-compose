#!/bin/bash

TODAY=`date +"%Y%m%d"`
BACKUP_PATH=/home/growi/backup
MONGO_CONTAINERID=2664abab
GROWI_CONTAINERID=2e0e2bf

sudo docker cp ${MONGO_CONTAINERID}:/data/db ${BACKUP_PATH}/db
sudo docker cp ${GROWI_CONTAINERID}:/data ${BACKUP_PATH}/data

sudo tar cvf ${BACKUP_PATH}/${TODAY}growi_mongodb.tar ${BACKUP_PATH}/db
sudo tar cvf ${BACKUP_PATH}/${TODAY}growi_uploaded.tar ${BACKUP_PATH}/data

sudo rm -rf ${BACKUP_PATH}/db
sudo rm -rf ${BACKUP_PATH}/data

find ${BACKUP_PATH} -name "*.tar" -mtime +7 -delete

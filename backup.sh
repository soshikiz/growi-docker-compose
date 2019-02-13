#!/bin/bash

TODAY=`date +"%Y%m%d"`
BACKUP_PATH=/home/growi/backup
MNT_POINT=/mnt/gcs-bucket
MONGO_CONTAINER_NAME=growi_mongo_1
GROWI_CONTAINER_NAME=growi_app_1
NETWORK_CONTAINER_NAME=growi_default

sudo docker run -it --rm --link ${MONGO_CONTAINER_NAME} --network ${NETWORK_CONTAINER_NAME} --volume ${BACKUP_PATH}:/backup mongo:3.4 bash -c "mongodump --host ${MONGO_CONTAINER_NAME} --db growi --out /backup"
sudo docker cp ${GROWI_CONTAINER_NAME}:/data ${BACKUP_PATH}/data
sudo tar -C ${BACKUP_PATH} -zcvf ${BACKUP_PATH}/${TODAY}_growi_backup.tar.gz growi data

if [ ! -d /mnt/gcs-bucket ]; then
	sudo mkdir ${MNT_POINT} 
fi

sudo gcsfuse soshikiz-wiki-backup ${MNT_POINT}

sudo cp ${BACKUP_PATH}/${TODAY}_growi_backup.tar.gz ${MNT_POINT} 
	
sudo rm -rf ${BACKUP_PATH}/growi
sudo rm -rf ${BACKUP_PATH}/data
sudo rm -rf ${BACKUP_PATH}/${TODAY}_growi_backup.tar.gz

sudo find ${MNT_POINT} -name "*.tar.gz" -mtime +7 -delete

sudo fusermount -u ${MNT_POINT}

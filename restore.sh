#!/bin/bash

BACKUP_PATH=$(pwd)/backup
MONGO_CONTAINER_NAME=growi_mongo_1
GROWI_CONTAINER_NAME=growi_app_1
NETWORK_CONTAINER_NAME=growi_default
MNT_POINT=/mnt/gcs-bucket
DATE


if [ $# -ne 1 ]; then
	echo "YYYYMMDDの形式で引数を指定してください" 1>&2
	exit 1
fi

BACKUP_FILE=$1_growi_backup.tar.gz
sudo gcsfuse soshikiz-wiki-backup ${MNT_PONT}

sudo cp ${MNT_POINT}/${BACKUP_FILE} ${BACKUP_PATH}
sudo tar -xvf ${BACKUP_PATH}/${BACKUP_FILE}

sudo docker run -it --rm --link ${MONGO_CONTAINER_NAME} --network ${NETWORK_CONTAINER_NAME} --volume ${BACKUP_PATH}:/backup mongo:3.4 bash -c "mongorestore -v --host ${MONGO_CONTAINER_NAME} --db growi backup/growi"
sudo docker cp  ${BACKUP_PATH}/data ${GROWI_CONTAINER_NAME}:/data

sudo rm -rf ${BACKUP_PATH}/data
sudo rm -rf ${BACKUP_PATH}/growi
sudo rm -rf ${BACKUP_PATH}/${BACKUP_FILE}


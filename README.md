growi-docker-compose for soshikiz
=====================

Quick start [GROWI](https://github.com/weseek/growi) with docker-compose

![GROWI-x-dockercompose](https://user-images.githubusercontent.com/1638767/38307565-105956e2-384f-11e8-8534-b1128522d68d.png)


Table of Contents
-----------------

1. [Start](#start)
1. [Upgrade](#upgrade)
1. [Backup](#backup)
1. [Documentation](#documentation)


Start
------

```bash
git clone https://github.com/soshikiz/growi-docker-compose.git growi
cd growi
docker-compose up -d
```

and access to https://wiki.soshikiz.com

### For High-memory environment

If you have enough memory, increase heap size for Elasticsearch with `ES_JAVA_OPTS` value in `docker-compose.yml`.

```yml
environment:
  - "ES_JAVA_OPTS=-Xms2g -Xmx2g"
```

Upgrade
-------

```bash
# go to growi-docker-compose workdir
cd growi

# stop
docker-compose stop

# remove current container and images
docker-compose rm app
docker rmi weseek/growi:3

# rebuild app container image
git pull
docker-compose build

# start
docker-compose up -d
```

Backup
------
```bash
# goto growi-docker-compose workdir
cd growi 

# execute backup script
./backup.sh
```
Restore
------
```bash
# goto growi-docker-compose workdir
cd growi 

# execute restore script
./restore.sh
```

Documentation
--------------

* [GROWI Docs](https://docs.growi.org/)
  
License
---------

* The MIT License (MIT)
* See LICENSE file.

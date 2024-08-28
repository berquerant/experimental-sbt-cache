#!/bin/bash

set -ex

if [ -z "$NO_BUILD" ] ; then
    # prepare cache directories if not exist
    mkdir -p .cache project/target target cache
    docker build \
       --tag experimental-sbt-cache \
       --progress plain \
       --build-arg SBT_BASE=cache/sbt \
       --build-arg IVY_HOME=cache/ivy \
       --build-arg CS_HOME=cache/cs \
       --build-arg BOOTD=cache/boot \
       "$@" \
       .
fi

# retrieve updated caches
rm -f sbt.cid
docker run --cidfile sbt.cid -d experimental-sbt-cache sh -c 'while true ; do sleep 60 ; done'
cid="$(cat sbt.cid)"
docker exec $cid ls -al /app/target /app/project/target /app/cache /root/.cache /root
docker cp $cid:/app/target/ .
docker cp $cid:/app/project/target/ project/
docker cp $cid:/app/cache/ .
docker cp $cid:/root/.cache/. .cache
docker container rm -f $cid
rm -f sbt.cid

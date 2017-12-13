#!/usr/bin/env sh

my_dir=$(realpath $(dirname $0))
secret_key_file=$my_dir/var/sentry-secret-key

# create a docker network named `hub`
if [ $(docker network ls | grep hub | wc -l) -lt 1 ]; then
    docker network create -d bridge hub
fi

if [ ! -f "$secret_key_file" ]; then
    $my_dir/setup.sh
fi

export secret_key=$(cat $secret_key_file)

docker-compose stop
docker-compose up -d --remove-orphans

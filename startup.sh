#!/usr/bin/env sh

my_dir=$(realpath $(dirname $0))
secret_key_file=$my_dir/var/sentry-secret-key

if [ ! -f "$secret_key_file" ]; then
    $my_dir/setup.sh
fi

export secret_key=$(cat $secret_key_file)

$my_dir/docker-compose.sh stop
$my_dir/docker-compose.sh up -d --remove-orphans

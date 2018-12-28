#!/usr/bin/env sh

#
# caution: --network docker-sentry_default
#

my_dir=$(realpath $(dirname $0))
secret_key_file=$my_dir/var/sentry-secret-key
var_dir=$my_dir/var

if [ -d "$var_dir" ]; then
    echo "$var_dir exists, please remove it manually"
    exit 1
fi

mkdir $var_dir

export secret_key=$(docker run --rm sentry config generate-secret-key | tee $secret_key_file)

$my_dir/docker-compose.sh stop
$my_dir/docker-compose.sh up -d sentry_redis sentry_postgres

docker run -it --rm \
    --network 'sentry' \
    -e SENTRY_SECRET_KEY="$secret_key" \
    -e SENTRY_POSTGRES_HOST=sentry_postgres \
    -e SENTRY_DB_USER=sentry \
    -e SENTRY_DB_PASSWORD=smile123 \
    -e SENTRY_REDIS_HOST=sentry_redis \
    -v $(pwd)/var/sentry:/var/lib/sentry/files \
    sentry upgrade

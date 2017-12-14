#!/usr/bin/env sh

auth_token=$1
dsn=$2

if [ -z "$auth_token" -o -z "$dsn" ]; then
    echo "usage: this-script auth_token dsn"
    exit 1
fi

docker run --rm -it \
    -e SENTRY_AUTH_TOKEN=$auth_token \
    -e SENTRY_DSN=$dsn \
    -v $(pwd)/var/sentry_cli:/work \
    --net=hub \
    getsentry/sentry-cli \
    sentry-cli "$@"


#!/usr/bin/env sh

if [ -z "$sentry_auth_token" -o -z "$sentry_dsn" ]; then
    echo "did you export sentry_auth_token and sentry_dsn before run this script ?"
    exit 1
fi

docker run --rm -it \
    -e SENTRY_AUTH_TOKEN=$sentry_auth_token \
    -e SENTRY_DSN=$sentry_dsn \
    -v $(pwd)/var/sentry_cli:/work \
    --net=sentry \
    getsentry/sentry-cli \
    sentry-cli "$@"


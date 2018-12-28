#!/usr/bin/env bash

PROJECT=sentry

exec docker-compose -p $PROJECT "$@"


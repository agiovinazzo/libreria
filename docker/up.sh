#!/bin/sh
docker-compose -p libreria up -d --remove-orphans $*

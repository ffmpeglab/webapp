#!/bin/sh
envsubst < ./config_template.json > ./webapp/config.json
http-server --proxy $PUBLIC_HOST? .
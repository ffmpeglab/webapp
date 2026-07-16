#!/bin/sh
envsubst < ./config_template.json > ./config.json
envsubst < ./config_template.json > ./webapp/config.json
echo $PUBLIC_HOST
http-server --proxy $PUBLIC_HOST? .
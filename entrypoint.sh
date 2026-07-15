#!/bin/sh
envsubst < ./config_template.json > ./config.json
envsubst < ./config_template.json > ./webapp/config.json
http-server --proxy "${FFMPEGLAB_HOST-http://localhost:8080/webapp/?}" .
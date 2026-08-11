#!/bin/sh
envsubst < /usr/share/nginx/html/config_template.json > /usr/share/nginx/html/webapp/config.json
nginx -g 'daemon off;'
#!/bin/sh
envsubst < /usr/share/nginx/config_template.json > /usr/share/nginx/html/webapp/config.json
envsubst < /usr/share/nginx/nginx.conf > /etc/nginx/conf.d/default.conf

cd /usr/share/nginx/html/

nginx -g 'daemon off;'
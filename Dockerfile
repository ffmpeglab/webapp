FROM nginx:alpine

COPY nginx.conf /etc/nginx/conf.d/default.conf

COPY webapp /usr/share/nginx/html/webapp

COPY config_template.json /usr/share/nginx/html

COPY entrypoint.sh /usr/share/nginx/html

EXPOSE 80

STOPSIGNAL SIGQUIT

WORKDIR /usr/share/nginx/html

ENTRYPOINT ["/usr/share/nginx/html/entrypoint.sh"]
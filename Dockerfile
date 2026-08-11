FROM nginx

COPY nginx.conf /etc/nginx/nginx.conf

COPY webapp /usr/share/nginx/html/webapp

COPY entrypoint.sh /usr/share/nginx/html

WORKDIR /usr/share/nginx/html/

CMD ["./entrypoint.sh"]
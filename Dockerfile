FROM alpine/git AS builder

WORKDIR /app

RUN git clone https://github.com/ffmpeglab/ffmpeglab.com.git website

FROM nginx:alpine

COPY nginx.conf /etc/nginx/conf.d/default.conf

COPY --from=builder website/* /user/share/nginx/html/

COPY webapp /usr/share/nginx/html/

COPY templates.json /usr/share/nginx/html/webapp/templates.json

COPY config_template.json /usr/share/nginx/

COPY entrypoint.sh /usr/share/nginx/

COPY nginx.conf /usr/share/nginx/

EXPOSE 3001

STOPSIGNAL SIGQUIT

WORKDIR /usr/share/nginx/

ENTRYPOINT ["/usr/share/nginx/entrypoint.sh"]
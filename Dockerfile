FROM node:22-alpine

RUN apk add --update gettext
 
RUN mkdir -p /home/node/app

WORKDIR /home/node/app/

COPY . .

RUN npm i -g http-server

CMD ["./entrypoint.sh"]
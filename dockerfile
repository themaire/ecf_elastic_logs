# syntax=docker/dockerfile:1

## Image's base
FROM node:latest as base
WORKDIR /usr/src/app

## Install libraries
RUN npm install express # Mini web server
RUN npm install @elastic/elasticsearch # Lib

ADD index.js .

EXPOSE 10000
ENTRYPOINT [ "node", "index.js" ]
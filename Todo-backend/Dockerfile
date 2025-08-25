# 1. Build stage

FROM node:22-alpine AS build

WORKDIR /app

COPY package*.json ./

RUN npm install --production

COPY . .

# STAGE 2: Production Stage

FROM node:22-alpine

WORKDIR /app

COPY --from=build /app/node_modules ./node_modules
COPY . .


EXPOSE 3001

ENTRYPOINT [ "npm" , "start" ]



FROM node:18.3.0-bullseye-slim
WORKDIR /usr/src/app
COPY . /usr/src/app
RUN yarn --frozen-lockfile
CMD yarn serve

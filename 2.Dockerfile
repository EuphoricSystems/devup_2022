FROM node:18.3.0-bullseye-slim
WORKDIR /usr/src/app
COPY . /usr/src/app
RUN yarn install --frozen-lockfile --production
CMD yarn serve

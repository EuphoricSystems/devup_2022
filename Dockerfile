FROM node:18.3.0-bullseye-slim as api-prep
RUN mkdir /dist
COPY ./package.json /dist
COPY ./yarn.lock /dist

WORKDIR /dist

RUN yarn install --frozen-lockfile --production

RUN rm -rf yarn.lock && \
    rm -rf package.json

FROM node:18.3.0-bullseye-slim as production-api

ENV NODE_ENV production

RUN mkdir -p /usr/src/api
RUN npm install pm2 -g

COPY --chown=node:node --from=api-prep  /dist /usr/src/api
COPY --chown=node:node ./dist/apps/api /usr/src/api

WORKDIR /usr/src/api

EXPOSE 3000

USER node

CMD [ "pm2-runtime", "main.js" ]

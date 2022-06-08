FROM node:18.3.0-bullseye-slim
ENV NODE_ENV production
WORKDIR /usr/src/app
COPY --chown=node:node . /usr/src/app
RUN yarn install --frozen-lockfile --production
USER node
CMD yarn serve

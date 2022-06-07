FROM node:lts-bullseye as ui-prep
RUN mkdir /dist
COPY ./package.json /dist
COPY ./yarn.lock /dist

WORKDIR /dist

RUN yarn install --production

RUN rm -rf yarn.lock && \
    rm -rf package.json

FROM node:lts-bullseye as api-prep
RUN mkdir /dist
COPY ./package.json /dist
COPY ./yarn.lock /dist

WORKDIR /dist

RUN yarn install --production

RUN rm -rf yarn.lock && \
    rm -rf package.json

FROM node:lts-bullseye as production-api
RUN mkdir -p /usr/src/api
RUN npm install pm2 -g

COPY --from=api-prep  /dist /usr/src/api
COPY ./dist/apps/api /usr/src/api

WORKDIR /usr/src/api

EXPOSE 3000

CMD [ "pm2-runtime", "main.js" ]

# Stage 1, based on Nginx, to have only the compiled app, ready for production with Nginx
FROM nginx:1.22.0 as production-ui

COPY ./scripts/start-nginx.sh /usr/bin/start-nginx.sh
RUN chmod +x /usr/bin/start-nginx.sh

# Install gomplate template renderer
COPY --from=hairyhenderson/gomplate:v3.10.0 /gomplate /usr/bin/gomplate

# Copy nginx conf template
COPY ./templates/nginx.conf.t /etc/nginx/nginx.conf.t
RUN rm -f /etc/nginx/nginx.conf

WORKDIR /usr/share/nginx/html
COPY --from=ui-prep /dist .
COPY ./dist/apps/ui-hub .

RUN rm -f ./assets/config.json

ENV HUB_API_PORT=3000

EXPOSE 4200

# Start nginx
ENTRYPOINT ["start-nginx.sh"]

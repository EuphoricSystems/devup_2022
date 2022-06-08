FROM node
WORKDIR /usr/src/app
COPY . /usr/src/app
RUN yarn
CMD yarn serve

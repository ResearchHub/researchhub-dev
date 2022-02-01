FROM node:14.15.5-alpine

# install dependencies
RUN apk add --no-cache --virtual .build-deps \
    git \
    python \
    make \
    g++ \
    bash



ADD ./researchhub-web /researchhub-web

WORKDIR /researchhub-web


RUN yarn install --modules-folder /node_modules/
ENV PATH=/node_modules/.bin:$PATH

CMD yarn dev
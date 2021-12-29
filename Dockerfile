# Image node:16.13.1-alpine3.14
FROM    node@sha256:a9b9cb880fa429b0bea899cd3b1bc081ab7277cc97e6d2dcd84bd9753b2027e1 AS base
WORKDIR /usr/src/app
COPY    package*.json ./
ENV     NUXT_HOST 0.0.0.0
ENV     NUXT_PORT 3000
EXPOSE  ${NUXT_PORT}/tcp

FROM    base AS development
ENV     NODE_ENV development
RUN     npm i
COPY    . ./

FROM    base AS generate
RUN     npm ci
COPY    . ./
RUN     npm run generate

# Serves static files with nginx in case of a SPA project, 
# it is necessary to set target as static in nuxt.config.js
# https://nuxtjs.org/docs/features/deployment-targets/
# Image nginx:1.20.2-alpine
FROM    nginx@sha256:74694f2de64c44787a81f0554aa45b281e468c0c58b8665fafceda624d31e556 AS production-static
# Fix CVE-2021-22945, CVE-2021-22946, CVE-2021-22947 and CVE-2021-40528
RUN     apk add --no-cache "curl>=7.79.0-r0" "libgcrypt>=1.8.8-r1" openssl bash \
        && rm -rf /usr/share/nginx/html/*
COPY    --from=generate /usr/src/app/dist/* /usr/share/nginx/html/
EXPOSE  80/tcp 443/tcp

FROM    base AS build
RUN     npm ci
COPY    . ./
RUN     npm run build

FROM    base AS deps
ENV     NODE_ENV production
RUN     npm ci --only=production \
        && npm cache clean --force \
        && npm prune --production --dry-run

# Check https://github.com/krallin/tini#why-tini
# Check https://github.com/nodejs/docker-node/tree/b4117f9333da4138b03a546ec926ef50a31506c3#nodealpine to understand why libc6-compat might be needed.
FROM    base AS production-universal
ENV     NODE_ENV production
RUN     apk add --no-cache tini libc6-compat
COPY    --chown=node:node --from=build /usr/src/app/.nuxt ./.nuxt
COPY    --chown=node:node --from=deps /usr/src/app/node_modules ./node_modules
COPY    --chown=node:node . ./
USER    node
CMD     [ "/sbin/tini", "--", "npm", "start" ]
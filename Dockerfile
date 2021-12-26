FROM node:lts-alpine3.14 AS base-stage

WORKDIR /app

COPY package*.json ./

ENV NUXT_HOST 0.0.0.0
ENV NUXT_PORT 3000

EXPOSE ${NUXT_PORT}

FROM base-stage AS dev-stage

ENV NODE_ENV=development

RUN npm install

COPY . ./

FROM base-stage AS build-stage

RUN npm ci

COPY . ./

RUN npm run build

FROM base-stage AS prod-stage

ENV NODE_ENV production

RUN apk --no-cache add dumb-init \
    && npm ci --only=production \
    && npm cache clean --force \
    && npm prune --production

COPY --from=build-stage /app/.nuxt ./.nuxt
COPY --chown=node:node . ./

USER node

CMD [ "dumb-init", "npm", "start" ]
FROM node:14-alpine

ENV NODE_ENV=development

WORKDIR /app

EXPOSE 3333

COPY package.json yarn.lock* ./

RUN yarn

ENV NUXT_HOST=0.0.0.0
ENV NUXT_PORT=3333

ENV PATH=./node_modules/.bin/:$PATH

COPY . .

CMD ["yarn", "dev"]
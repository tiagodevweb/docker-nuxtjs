FROM node:14-alpine
ENV NODE_ENV=development
WORKDIR /app
COPY package*.json ./
RUN npm i --silent
COPY . .
EXPOSE 3000
ENV NUXT_HOST=0.0.0.0
ENV NUXT_PORT=3000
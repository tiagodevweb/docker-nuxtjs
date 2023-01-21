# Docker Nuxt JS 

Node lab for development and production with docker and a Nuxt JS application.

## Requirements

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Intro

[Docker](https://docs.docker.com/get-docker/) helps developers bring their ideas to life by conquering the complexity of app development. We simplify and accelerate development workflows with an integrated dev pipeline and through the consolidation of application components. Actively used by millions of developers around the world, Docker Desktop and Docker Hub provide unmatched simplicity, agility and choice.

[Docker Compose](https://docs.docker.com/compose/) is a tool for defining and running multi-container Docker applications. With Compose, you use a YAML file to configure your application’s services. Then, with a single command, you create and start all the services from your configuration.

[Nuxt](https://nuxtjs.org/) is an open source framework that makes web development simple and powerful.

## Usage

#### Development

up container
```bash
docker-compose up -d
```
![docker-compose up -d](/md/dc-up.png "docker-compose up -d")

list container
```bash
docker-compose ps
```
![docker-compose ps](/md/dc-ps.png "docker-compose ps")

show container logs
```bash
docker-compose logs
```
![docker-compose logs](/md/dc-logs.png "docker-compose logs")

#### Production

Build universal image
```bash
DOCKER_BUILDKIT=1 docker build -t myapp --target production-universal .
```

```bash
docker run --rm -it -p 3000:3000 myapp
```
![docker build](/md/dr-u.png "docker build")

[http://localhost:3000](http://localhost:3000)

Build static image
```bash
DOCKER_BUILDKIT=1 docker build -t myapp:static --target production-static .
```
```bash
docker run --rm -it -p 80:80 myapp:static
```
![docker build](/md/dr-s.png "docker build")

[http://localhost](http://localhost)

## License

The Docker Nuxt JS is open-sourced software licensed under the [MIT license](https://opensource.org/licenses/MIT).


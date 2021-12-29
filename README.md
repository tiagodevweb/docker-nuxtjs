# Dockerize Nuxt JS 

Node lab for development and production with docker and a Nuxt JS application.

## Requisitos

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Usage

#### Development

up container
```bash
docker-compose up -d
```
list container
```bash
docker-compose ps
```
show container logs
```bash
docker-compose logs
```

#### Production

Build universal image
```bash
DOCKER_BUILDKIT=1 docker build -t <universal-image-name> --target production-universal .
```
```bash
docker run --rm -it -p 3000:3000 <universal-image-name>
```
[http://localhost:3000](http://localhost:3000)

Build static image
```bash
DOCKER_BUILDKIT=1 docker build -t <static-image-name> --target production-static .
```
```bash
docker run --rm -it -p 80:80 <static-image-name>
```
[http://localhost](http://localhost)

## License

The Dockerize Nuxt JS is open-sourced software licensed under the [MIT license](https://opensource.org/licenses/MIT).


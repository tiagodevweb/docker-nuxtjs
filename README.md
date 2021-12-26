# Dockerize Node 

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

Build image
```bash
DOCKER_BUILDKIT=1 docker build -t <image-name> --target prod-stage .
```
Run container
```bash
docker run --rm -it -p 3000:3000 <image-name>
```

[http://localhost:3000](http://localhost:3000).

## License

The Dockerize Node is open-sourced software licensed under the [MIT license](https://opensource.org/licenses/MIT).


# Building on Linux (Docker)

- Go to "docker" directory: `cd $REPO/docker`
- Compose docket image: `docker-compose build`.
- Build sources: `docker-compose run --rm down`.
- Login docker image (i.e. to troubleshoot build failures): `docker-compose run --rm down bash`. After that you can run `swift build --package-path /app` or `cd /app && swift build`.

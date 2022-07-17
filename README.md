# Docker Compose Configuration

Configuration of multiple docker-compose.yml service file examples.

## How to install docker compose

- Download the docker-compose file

```sh
sudo curl -L https://github.com/docker/compose/releases/download/1.16.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
```

- Add executable permission to the file.

```sh
sudo chmod +x /usr/local/bin/docker-compose
```

- Test installation results.

```sh
docker-compose --version
```

## [Docker compose common commands](https://docs.docker.com/engine/reference/commandline/docker/)

- build: Build container.
- ps: List all containers of the current project.
- up: Build the container and start the container, common parameters: -d background start, - specify the configuration file.
- exec: Into the specified container.
- top: View the running status of each container in the project.
- logs: View the output of the container.
- down: Stop and remove all containers and remove the corresponding network.
- rm: Remove all stalled containers.
- start/stop/restart: Start container/stop container/restart container.

## [Docker compose format](https://docs.docker.com/compose/compose-file/)

- version: Specify the compsoe version corresponding to the current file, mainly 1, 2.x and 3.x
- services: service list
   - [service-name]: service name
     - image: Specify the running image, you can directly pull the existing image for processing
     - build: Set the folder where the Dockerfile is located, which can process images that need to be built with Dockerfile
       - content: the path to store the Dockerfile
       - dockerfile: Specifies the Dockerfile filename for the build
       - args: build arguments, only accessible during the build process
     - container_name: set the container name
     - restart: restart strategy, there are no, always, no-failure, unless-stoped
     - ports: Expose the port of the container, the format is host port: container port
       - 8080:8080
     - hostname: set the hostname of the container
     - volumes: Set the mount point of the container, which can be mounted on the host, the main format is host path: container path [: access mode]
       - /opt/data:/opt/data
       - /var/lib/mysql:/var/lib/mysql:rw
     - volumes_from: mount all data volumes of another service or container
       - service_name
       - container_name
     - environment: set environment variables
       - RACK_ENV=development
- networks: configure networks
  - app_netwotk:

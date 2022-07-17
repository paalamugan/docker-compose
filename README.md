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

## [Dockerfile instructions](https://docs.docker.com/engine/reference/builder/)

Before understanding Docker compose, you need to understand Dockerfile.

### FROM
Specify the base image, usually the first instruction of the file, but in fact, you can also use ARG as the first instruction.

```
  # Format
   FROM [--platform=<platform>] <image> [AS <name>]  
   FROM [--platform=<platform>] <image>[:<tag>] [AS <name>] 
   FROM [--platform=<platform>] <image>[@<digest>] [AS <name>]

  # Usage
   FROM centos
   FROM openjdk:8-jre
   FROM node:12.18.4-alpine@sha256:757574c5a2...
```
**Parameter Description:**
   - [ — platform=<platform>] is an optional parameter, which can be used to specify the platform of the image, such as Linux/amd64, Linux/arm64, or windows/amd64, usually the default.
   - <image> is the image name, followed by :tag is the version number used to specify the image, and @digest is the content-addressable identifier (you can go to the official website for details). Generally, we only use tags. If two If neither is specified, the latest version is obtained
   - [as <name>] is the name of the current build stage, because multiple FROMs can be used in the Dockerfile to create multiple images, so using as <name> can be used in the following COPY command, use — from=<name> to refer to The image built earlier, such as copying the files generated by the previous image, etc.

### ARG
This command is used to specify a variable that is passed to the build runtime. It can set a default value. When building a container with the docker build command, use — build-arg <varname> = <value> to pass parameters.

```
# Format
ARG <name>[=<default value>]

# Usage
ARG CODE_VERSION=laster
ARG testArg=123

# Parameter
FROM centos:7
ARG parameter=123
RUN echo $parameter

docker build --build-arg parameter=234 -t test:1.0

# Note
# ARG can be used before FROM, outside of the FROM build phase, so it cannot be used in any instructions after FROM.
ARG CENTOS_VERSION=laster
FROM centos:${CENTOS_VERSION}
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

## [Docker compose file structure](https://docs.docker.com/compose/compose-file/)

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

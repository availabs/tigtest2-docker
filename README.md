# NYMTC TIG In Docker

## Deployment

### Configuration

All configuration and credential files belong in the _config/_ directory.

#### _config/.env_ file

For simplification and automation, the _config/.env_ file completely centralizes
the gateway configuration.
Utility scripts use _config/.env_ to automate the gateway's Rails server configuration
as well as the host server's NGINX configuration.

Use the _config/.env.template_ to create a _config/.env_.
The template contains instructive comments and the variable names should be self-explanatory.

#### config/id_rsa

The [availabs/tigtest2](https://github.com/availabs/tigtest2) repository is private.
GitHub authorization is required to clone a copy of the repository.
For noninteractive cloning and updating of the repository, we created a GitHub Read-Only
[Deploy Key](https://docs.github.com/en/developers/overview/managing-deploy-keys#deploy-keys).

Having a Deploy Key is not necessary to get and use the gateway app,
however it does allow complete automation of the cloning and updating process.

If you have a Deploy Key, place it in config/id_rsa.

#### _config/nginx.\*.template.conf_

Scripts use these templates to generate actual configuration files.
Editing these template files may break the automated configuration scripts.

### Initialize the Gateway

```sh
./bin/init-gateway
```

The above script does the following three things:

- Clones the [availabs/tigtest2](https://github.com/availabs/tigtest2) repository
  onto the host machine using the deploy key in config/id_rsa.
- Installs the gateway's Ruby dependencies.
- Updates the gateway's configuration files using _config/.env_

### Deploy the Gateway

Start the gateway in a Docker container:

```sh
./bin/deploy-gateway
```

To shut down the gateway:

```sh
./bin/shutdown-gateway
```

## Development

### Building the Docker image

The [ptomchik/nymtc_tig](https://hub.docker.com/repository/docker/ptomchik/nymtc_tig)
Docker images are created to facilitate NYMTC TIG deployment. The TIG Rails server's
system dependencies are packaged together in a consistent, isolated, and immutable
environment.

The images are publicly hosted on [DockerHub](https://hub.docker.com).
Because the Docker images are public, great care _MUST_ be given to ensure
no gateway secrets are contained in the Docker images. Achiving this
is quite easy. The Docker images _MUST_ be build _WITHOUT_ access to
the [availabs/tigtest2](https://github.com/availabs/tigtest2) itself.
**Never copy the gateway's GitHub repository into the Docker image while building.**
Even if the repository is later deleted, it will remain in the build layers
of the image. In other words, the Dockerfile MUST NEVER include a COPY step
that brings the gateway codebase into the build process.

As a consequence of the Docker build process' necessary lack of access to the
gateway's codebase, before deploying the gateway the Ruby dependencies
must be installed using _./bin/install-dependencies_ utility script.
This means that the image does not completely encapsulate all the apps dependencies.

However, a [technique](https://blog.alexellis.io/mutli-stage-docker-builds/) exists
that may allow all the gateway's dependencies to be included in the
public Docker image without leaking secrets. Further research is required
before this technique is applied, though.

The docker image is public on DockerHub.

However, to build new version you can update the GATEWAY*DOCKER_IMG variable in \_config/.env*
and run

```sh
./bin/build
```

### Guarding Secrets

This repository is public. It is therefore critical to protect any secrets.

Files containing secrets MUST only be added to the _config/_ directory.

The _config/.gitignore_ file ensures that files containing secrets are not
committed to the repository history or sent to GitHub.
For documentation see [link](https://git-scm.com/docs/gitignore).
It is configured to whitelist only those files that _DO NOT_ contain secrets.

The _config/.env_ file contains secrets such as database connection credentials.
It MUST NEVER be committed to the GitHub repository.
The _config/.env.template_ is provided for users create a _config/.env_ file.
Because _config/.env.template_ must be included in this repository,
**config/.env.template MUST NEVER include any secrets**.

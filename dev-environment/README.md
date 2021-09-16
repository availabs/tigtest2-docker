# TIG Docker Development Environment

## Starting a dev container

In the project root:

```sh
./run-attached-dev-env
```

### Starting the server for development

In the container

```sh
rake assets:precompile

bundle exec puma -C config/puma.rb
```

Use to start NGINX in Docker, on the host

```sh
./bin/start-nginx-docker
```

### Bummr

Make sure

- the gateway repo is [availabs/tig-upgraded](https://github.com/availabs/tig-upgraded).
- the gateway branch is dev-incremental-dependency-upgrades-bummr-work-branch
- the branch is clean

Running bummr:

```sh
BUMMR_TEST='/home/deploy/gateway-tests/run-tests' \
BASE_BRANCH='dev-incremental-dependency-upgrades' \
BUMMR_HEADLESS=true \
  bundle exec bummr update \
    &> bummr_pass2_log
```

Document each Bummr pass in gateway's bummr_passes/ directory.

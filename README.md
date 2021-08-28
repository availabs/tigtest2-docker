# NYMTC TIG In Docker

## Build the Docker image

```sh
./bin/build
```

## Configuration

### ./config/.env file

Create a ./config/.env file using the ./config/.env.template

### ./config/.ssh

Used to clone the availabs/tigtest2 repo.

Must contain the id_rsa used for a GitHub deploy key.

```sh
$ tree config/.ssh
config/.ssh
├── id_rsa
├── id_rsa.pub
└── known_hosts
```

The known_hosts must include GitHub's 

## Clone the project

```sh
./bin/get-getway
```

# Install the Ruby and the packages and copy them to host for reuse.

```sh
./bin/init-gateway
```

## Launch the server

```sh
./bin/deploy-gateway
```

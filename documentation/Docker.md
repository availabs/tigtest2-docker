# Docker

## Overview

- [Docker Overview](https://docs.docker.com/get-started/overview/)

- [What is a container?](https://azure.microsoft.com/en-us/overview/what-is-a-container/)

## Security

- [Docker security](https://docs.docker.com/engine/security/#docker-daemon-attack-surface)
- [Builder pattern vs. Multi-stage builds in Docker](https://blog.alexellis.io/mutli-stage-docker-builds/)
- [Use multi-stage builds](https://docs.docker.com/develop/develop-images/multistage-build/#before-multi-stage-builds)
- [Advanced Dockerfiles: Faster Builds and Smaller Images Using BuildKit and Multistage Builds](https://www.docker.com/blog/advanced-dockerfiles-faster-builds-and-smaller-images-using-buildkit-and-multistage-builds/)

## Legal

- [Docker containers: What are the open source licensing considerations?](https://www.linuxfoundation.org/resources/publications/docker-containers-what-are-the-open-source-licensing-considerations/)

- [License for docker images?](https://opensource.stackexchange.com/questions/7013/license-for-docker-images/8240)

- [Ruby License](https://www.ruby-lang.org/en/about/license.txt)

- [RVM License](https://rvm.io/license)

[source](https://stackoverflow.com/a/43817471/3970755)

```sh
for i in `gem list | cut -d" " -f1`; do echo "$i :" ; gem spec $i license; done
```

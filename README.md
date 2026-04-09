## Development environment
Development is done inside a **Docker** container, docker image taken from [meta-flutter/docker-containers](https://github.com/meta-flutter/docker-containers/blob/main/ubuntu-24-dev/Dockerfile) with minor modifications.

### AGL resources
Take from
```
repo init -u https://gerrit.automotivelinux.org/gerrit/AGL/AGL-repo.git -b master
repo sync
```
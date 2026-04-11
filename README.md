# GSOC26 AGL quiz 
This is a quiz to apply for the gsoc26 projects of the Automotive Grade Linux group, from the Linux Foundation.
Task is to develop a flutter app with some requirements, then embed it in an AGL image using yocto layers.

## The app
**my_app** has one button to play a sound *Honk*, other one to show an image (*rear view of the vehicle*). Also show information of the system the app is running using the device_info package.

## Development environment
Development is done inside a **Docker** container, docker image taken from [meta-flutter/docker-containers](https://github.com/meta-flutter/docker-containers/blob/main/ubuntu-24-dev/Dockerfile) with minor modifications.

### AGL resources
Take from
```
repo init -u https://gerrit.automotivelinux.org/gerrit/AGL/AGL-repo.git -b master
repo sync
```


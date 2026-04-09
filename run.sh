# allow the container to open graphical interfaces
xhost +local:docker

docker compose run --remove-orphans base bash
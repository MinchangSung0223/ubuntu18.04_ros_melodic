#!/bin/bash


docker rm -f ubnutu_18.04 ||
docker rm -f ubnutu_18.04:latest ||

xhost +local:root
 docker  run  --rm -it -d --name ubnutu_18.04 --privileged  --volume=/dev:/dev --gpus all --net=host -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY -e QT_X11_NO_MITSHM=1 ubnutu_18.04:latest bash &&

docker cp ~/.ssh/id_rsa ubnutu_18.04:/root/.ssh/
docker cp ~/.ssh/id_rsa.pub ubnutu_18.04:/root/.ssh/
xhost +local:root
bash multi_terminal.sh


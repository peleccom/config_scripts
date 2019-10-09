#!/bin/sh

df -h

# Clear yarn cache
yarn cache clean

# Clear npm cache
npm cache clean --force

#Docker
docker rm $(docker ps -q -f "status=exited")

docker rmi $(docker images -q -f "dangling=true")


sudo apt clean

sudo apt autoremove --purge

df -h

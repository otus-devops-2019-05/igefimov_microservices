#!/bin/bash

docker kill $(docker ps -q)

docker run -d --network=reddit --network-alias=post_db --network-alias=comment_db -v reddit_db:/data/db mongo:latest
docker run -d --network=reddit --network-alias=post igefimov/post:1.0
docker run -d --network=reddit --network-alias=comment igefimov/comment:1.0
docker run -d --network=reddit -p 9292:9292 igefimov/ui:3.0
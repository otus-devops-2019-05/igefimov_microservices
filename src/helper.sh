#!/bin/bash

docker run -d --network=reddit --network-alias=post_db --network-alias=comment_db mongo:latest
docker run -d --network=reddit --network-alias=post igefimov/post:1.0
docker run -d --network=reddit --network-alias=comment igefimov/comment:1.0
docker run -d --network=reddit -p 9292:9292 igefimov/ui:3.0
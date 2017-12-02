#!/usr/bin/env bash

docker rm -vf $(docker ps -a) 2>/dev/null || echo "No stopped containers to remove."

docker rmi -f $(docker images) 2>/dev/null || echo "No untagged images to delete."

docker volume rm $(docker volume ls) 2>/dev/null || echo "No volumes to delete."

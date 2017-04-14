#!/bin/bash
set -e

git pull
docker build -t findshow:latest .
docker stop $(docker ps -lq)
docker run -d -p 80:80 findshow:latest
sleep 10
/bin/bash -l -c 'docker exec $(docker ps -lq) bundle exec rake db:migrate'

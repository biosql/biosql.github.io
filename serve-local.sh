#!/bin/bash

image=${1:-jekyll/jekyll}
tag=pages

if [[ "$image" == "jekyll/jekyll" ]] ; then
    docker pull ${image}:$tag
else
    docker build -t ${image}:$tag .
fi
docker run --rm --volume=$(pwd):/srv/jekyll -it -p 127.0.0.1:4000:4000 ${image}:$tag jekyll serve --config _config.yml,_config-dev.yml --drafts

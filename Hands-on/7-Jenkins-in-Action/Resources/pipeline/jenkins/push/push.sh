#!/bin/bash

echo "********************"
echo "** Pushing image ***"
echo "********************"

IMAGE="maven-project"

echo "** Logging in ***"
docker login -u atingupta2005 -p $PASS
echo "*** Tagging image ***"
docker tag $IMAGE:$BUILD_TAG atingupta2005/$IMAGE:$BUILD_TAG
echo "*** Pushing image ***"
docker push atingupta2005/$IMAGE:$BUILD_TAG

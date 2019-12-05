#!/bin/bash
set -e -o pipefail

echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

if [[ -n $TRAVIS_TAG ]]; then
    TAG=${TRAVIS_TAG/v/}
    echo "publish $TAG"
	docker tag dockeralioua/Jenkins-dind dockeralioua/Jenkins-dind:${TAG}
	docker tag dockeralioua/Jenkins-dind:alpine dockeralioua/Jenkins-dind:${TAG}-alpine
	docker tag dockeralioua/Jenkins-dind:debian dockeralioua/Jenkins-dind:${TAG}-debian
	docker tag dockeralioua/Jenkins-dind:jdk11 dockeralioua/Jenkins-dind:${TAG}-jdk11
	docker push dockeralioua/Jenkins-dind:${TAG}
	docker push dockeralioua/Jenkins-dind:${TAG}-alpine
	docker push dockeralioua/Jenkins-dind:${TAG}-debian
	docker push dockeralioua/Jenkins-dind:${TAG}-jdk11

else
    echo "publish latest"
	docker push dockeralioua/Jenkins-dind
	docker push dockeralioua/Jenkins-dind:alpine
	docker push dockeralioua/Jenkins-dind:debian
	docker push dockeralioua/Jenkins-dind:jdk11
fi

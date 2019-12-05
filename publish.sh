#!/bin/bash
set -e -o pipefail

echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

if [[ -n $TRAVIS_TAG ]]; then
    TAG=${TRAVIS_TAG/v/}
    echo "publish $TAG"
	docker tag alioualarbi/Jenkins-dind dockeralioua/jenkins-dind:${TAG}
	docker tag alioualarbi/Jenkins-dind:alpine dockeralioua/jenkins-dind:${TAG}-alpine
	docker tag alioualarbi/Jenkins-dind:debian dockeralioua/jenkins-dind:${TAG}-debian
	docker tag alioualarbi/Jenkins-dind:jdk11 dockeralioua/jenkins-dind:${TAG}-jdk11
	docker push alioualarbi/Jenkins-dind:${TAG}
	docker push alioualarbi/Jenkins-dind:${TAG}-alpine
	docker push alioualarbi/Jenkins-dind:${TAG}-debian
	docker push alioualarbi/Jenkins-dind:${TAG}-jdk11

else
    echo "publish latest"
	docker push dockeralioua/jenkins-dind
	docker push dockeralioua/jenkins-dind:alpine
	docker push dockeralioua/jenkins-dind:debian
	docker push dockeralioua/jenkins-dind:jdk11
fi

#!/bin/bash
# builds jenkins build server image and pushes to DTR

# stop script execution should error occur
set -e
# show script with all parameters passed => $@
echo "executing $0 $@"

IMAGE_TAG=${1:-"1.0"}
IMAGE_NAME=${2:-"jenkins-build-server"}
DTR_REPO=${3:-"admin"}
DTR_FQDN=${4}
# didn't work with port. need to re-test
DTR_PORT=${5:-443}
# not sure if I need IP or should use FQDN
DTR_IP=${6}

# output colors
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
NORMAL=$(tput sgr0)


if [[ -z "$DTR_FQDN" ]]; then
    read -p "Provide DTR full domain name (FQDN): " DTR_FQDN
fi
echo $GREEN "building image using FQDN '$DTR_FQDN'..." $NORMAL
docker image build -t ${DTR_FQDN}/$DTR_REPO/$IMAGE_NAME:$IMAGE_TAG .
echo "logging into DTR..."
docker login -u ${DTR_REPO} ${DTR_FQDN}
echo "pushing image to DTR..."
docker image push ${DTR_FQDN}/$DTR_REPO/$IMAGE_NAME:$IMAGE_TAG
echo $GREEN "image '$IMAGE_NAME:$IMAGE_TAG' was pushed to '${DTR_FQDN}/$DTR_REPO' DTR repository" $NORMAL


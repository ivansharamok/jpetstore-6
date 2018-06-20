#!/bin/bash
# runs jenkins server as container

# stop script execution should error occur
set -e
# show script with all parameters passed => $@
echo "executing $0 $@"

IMAGE_TAG=${1:-"1.0"}
IMAGE_NAME=${2:-"jenkins-build-server"}
# alex is a member of Developer role
DTR_REPO=${3:-"alex"}
DTR_FQDN=${4}
# didn't work with port. need to re-test
DTR_PORT=${5:-443}
# not sure if I need IP or can just use FQDN
DTR_IP=${6}

# output colors
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
NORMAL=$(tput sgr0)


if [[ -z "$DTR_FQDN" ]]; then
    read -p "Provide DTR full domain name (FQDN): " DTR_FQDN
fi

echo "logging into DTR..."
docker login -u ${DTR_REPO} ${DTR_FQDN}
# ASSUMPTIONS
# this configuration assumes that cloudstor plugin is installed and configured for Azure Files
# there are 2 volume binds that assume existence of Azure Files resource
# it also assumes that jenkins server is constrained to a node that has 'jenkins: master' label
SERVICE_NAME="my-jenkins"
echo $GREEN "creating jenkins server..." $NORMAL
docker service create --name $SERVICE_NAME --publish 8080:8080 \
    --mount type=bind,source=/var/run/docker.sock,destination=/var/run/docker.sock \
    --mount \
    type=volume,volume-driver=cloudstor:azure,source=jenkins,destination=/var/jenkins_home,volume-opt=share=jenkins \
    --mount \
    type=volume,volume-driver=cloudstor:azure,source=ucpbundle,destination=/home/jenkins/ucp-bundle-admin,volume-opt=share=ucpbundle \
    --constraint 'node.labels.jenkins == master' \
    --detach=false \
    -e DTR_IP=${DTR_FQDN} \
    ${DTR_FQDN}/$DTR_REPO/$IMAGE_NAME:$IMAGE_TAG
echo $GREEN "started jenkins as service '$SERVICE_NAME'" $NORMAL
echo "make sure to open necessary ports if there is firewall or LB involved"


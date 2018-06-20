#!/bin/bash
# script created and tested for Jenkins job
# builds image from Github repo and pushes it to DTR
# assumes DTR_URL parameter defined in Jenkins build project
export DTR_FQDN=${DTR_URL}
docker image build -t ${DTR_FQDN}/alex/jps -f ${WORKSPACE}/docker/jps/Dockerfile .
docker image tag ${DTR_FQDN}/alex/jps ${DTR_FQDN}/alex/jps:1.${BUILD_NUMBER}
docker login -u admin -p ucp@dm1n ${DTR_FQDN}
docker image push ${DTR_FQDN}/alex/jps
docker image push ${DTR_FQDN}/alex/jps:1.${BUILD_NUMBER}

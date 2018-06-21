#!/bin/bash
# script created and tested for Jenkins job
# Jenkins project is expected to be parametrized and have these parameters defined:
#   DTR_URL, DB_ROOT_USER_SECRET, DB_ROOT_PASSWORD_SECRET, DB_USER_SECRET, DB_PASSWORD_SECRET, STACK_NAME
echo "deploying web app with stack '$STACK_NAME'..."
docker stack deploy -c ${WORKSPACE}/docker/compose/jps-compose.yml ${STACK_NAME}

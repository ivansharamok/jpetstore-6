#!/bin/bash
# script created and tested for Jenkins job
# create volume using 'cloudstor' plugin for Azure Files
# populate mysql db with jpetstor initial data

CONTAINER_NAME="mysql-init"

# mount parameter assumes 'cloustor' plugin was installed as 'cloudstor:azure'
docker run --rm -d --name $CONTAINER_NAME \
    --mount type=volume,volume-driver=cloudstor:azure,source=jpsdata,destination=/var/lib/mysql,volume-opt=share=jpsdata ${DTR_URL}/alex/mysql-jps
# populate jpetstore db
docker exec $CONTAINER_NAME /jpetstore/scripts/db-loaddata.sh
# wait until jpetstore db gets populated
max_tries=15
# default count of products is 16
# TODO: replace hard-coded user/password with variables
while [[ $(docker exec $CONTAINER_NAME mysql -N -uroot -proot -e "select count(*) from jpetstore.PRODUCT") != "16" ]]; do
    if [[ $max_tries -eq 0 ]]; then
        break
    fi
    sleep 2
    echo "waiting for db data to be loaded ($max_tries attempts left)"
    (( max_tries-- ))
done

# remove container by killing it
docker kill $CONTAINER_NAME
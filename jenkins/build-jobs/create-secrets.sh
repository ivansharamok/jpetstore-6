#!/bin/bash
# script created and tested for Jenkins job
# Jenkins project is expected to be parametrized and have these parameters defined:
#   DB_ROOT_USER, DB_ROOT_PASSWORD, DB_USER, DB_PASSWORD
# create secret function
create_secret() {
    sname=${1}
    svalue=${2}
    SECRET_NAME=$(docker secret ls -f "name=$sname" --format '{{.Name}}')
    if [[ -z $SECRET_NAME ]]; then
        # create secret
        printf $svalue | docker secret create $sname -
    else
        echo "secret $sname already exists, skipping creation..."
    fi
}
# create secret mysql_root_user
create_secret 'mysql_root_user' ${DB_ROOT_USER}
# create secret mysql_root_password
create_secret 'mysql_root_password' ${DB_ROOT_PASSWORD}
# create secret mysql_user
create_secret 'mysql_user' ${DB_USER}
# create secret mysql_password
create_secret 'mysql_password' ${DB_PASSWORD}

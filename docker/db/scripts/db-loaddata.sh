#!/bin/bash
# until mysql -uroot -proot -e "select 1" 
# do 
#     echo "Waiting for database connection..."
#     # wait for 5 seconds before check again 
#     sleep 5 
# done
echo "loading data into jpetstore"
mysql -uroot -proot < /jpetstore/scripts/sql/jps-dataload.sql

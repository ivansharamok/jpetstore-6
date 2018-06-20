FROM mysql:5.7

# use secrets when creating service in prod environment
# secrets can be defined using ENV variables:
#   MYSQL_ROOT_PASSWORD_FILE=/run/secrets/mysql_root_password
#   MYSQL_PASSWORD_FILE=/run/secrets/mysql_root_password
ENV MYSQL_DATABASE=jpetstore \
    MYSQL_ROOT_PASSWORD=root \
    MYSQL_USER=jps \
    MYSQL_PASSWORD=jps

#ADD sql/jps-schema.sql /docker-entrypoint-initdb.d/
# use WORKSPACE variable from jenkins server
ADD ${WORKSPACE}/docker/db/sql/jps-schema-if-not-exists.sql /docker-entrypoint-initdb.d/
RUN mkdir -p /jpetstore/scripts/sql
COPY ${WORKSPACE}/docker/db/sql/ /jpetstore/scripts/sql/
COPY ${WORKSPACE}/docker/db/scripts/db-loaddata.sh /jpetstore/scripts/
RUN chmod 700 /jpetstore/scripts/db-loaddata.sh
#RUN echo "hello"

EXPOSE 3306
#CMD ["sh", "-c", "/jpetstore/scripts/db-loaddata.sh"]
FROM mysql:5.7

ENV MYSQL_DATABASE=jpetstore \
    MYSQL_ROOT_PASSWORD=root \
    MYSQL_USER=jps \
    MYSQL_PASSWORD=jps

ADD $PWD/res/db/jps-schema.sql /docker-entrypoint-initdb.d
RUN mkdir -p /jpetstore/scripts/db
COPY $PWD/res/db/ /jpetstore/scripts/db
COPY $PWD/scripts/db-loaddata.sh /jpetstore/scripts
RUN chmod 700 /jpetstore/scripts/db-loaddata.sh
RUN echo "hello"

EXPOSE 3306
#CMD ["sh", "-c", "/jpetstore/scripts/db-loaddata.sh"]
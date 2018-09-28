# Insipred by https://github.com/CliffordAnderson/docker-containers/blob/master/neo4j/Dockerfile
# Includes JDBC plugins
# https://neo4j.com/developer/kb/how-do-i-use-cypher-to-connect-to-a-rbms-using-jdbc/

FROM neo4j
MAINTAINER Ravi Huang <ravi.huang@gmail.com>

ARG APOC_VERSION=3.4.0.3
ARG PG_JDBC_VERSION=42.2.5
ENV APOC_URI https://github.com/neo4j-contrib/neo4j-apoc-procedures/releases/download/${APOC_VERSION}/apoc-${APOC_VERSION}-all.jar
ENV POSTGRES_URI https://jdbc.postgresql.org/download/postgresql-${PG_JDBC_VERSION}.jar
ARG MYSQL_JDBC=https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-8.0.12.tar.gz

RUN apk add --no-cache --quiet curl && \
    curl --fail --silent --show-error --location --output plugins/apoc-${APOC_VERSION}-all.jar $APOC_URI && \
    curl --fail --silent --show-error --location --output plugins/postgresql-${PG_JDBC_VERSION}.jar $POSTGRES_URI && \
    curl --fail --silent --show-error --location -O ${MYSQL_JDBC} && \
    tar xzvf *.tar.gz && mv mysql-connector-java-8.0.12/mysql-connector-java-8.0.12.jar plugins && \
    rm -rf mysql-connector-java-8.0.12* && \
    apk del curl


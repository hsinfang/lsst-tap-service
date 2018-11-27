#!/bin/bash -e

gradle --info clean build
cp build/libs/tap##1000.war docker
(cd docker && docker build . -t lsstdax/lsst-tap-demo:latest -f Dockerfile)
(cd docker && docker build . -t lsstdax/oracle-db-demo:latest -f Dockerfile.oracle)
(cd docker && docker build . -t lsstdax/postgresql-db-demo:latest -f Dockerfile.postgresql)
(cd docker && docker build . -t lsstdax/mysql-db-demo:latest -f Dockerfile.mysql)
(cd docker && docker build . -t lsstdax/presto:latest -f Dockerfile.presto)

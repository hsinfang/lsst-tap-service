#!/bin/bash -e

docker push lsstdax/oracle-db-demo:latest
docker push lsstdax/postgresql-db-demo:latest
docker push lsstdax/mysql-db-demo:latest
docker push lsstdax/lsst-tap-demo:latest
docker push lsstdax/presto:latest

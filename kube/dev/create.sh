#!/bin/bash -ex
# Run the TAP service in a development environment,
# like a GKE cluster.  This assumes there is no
# QServ to connect to.

# Create the oracle backend for TAP data.
kubectl create -f oracle-deployment.yaml
kubectl create -f oracle-service.yaml

# Create the backend for TAP_SCHEMA data.
kubectl create -f tap-schema-deployment.yaml
kubectl create -f tap-schema-service.yaml

# Create the mock qserv backend if we're not at NCSA
kubectl create -f mock-qserv-deployment.yaml
kubectl create -f mock-qserv-service.yaml

# Create the postgresql backend for UWS data.
kubectl create -f postgresql-deployment.yaml
kubectl create -f postgresql-service.yaml

# Create the Presto deployment using Helm.
if [ ! -d "/tmp/presto-chart" ]; then
  # Use this version of the presto chart, which supports creating
  # backends via the values.yaml.
  git clone https://github.com/lotuc/presto-chart.git /tmp/presto-chart
fi

helm install -f presto-helm-values.yaml /tmp/presto-chart/ --name dax-dev

# Create the CADC TAP service.
kubectl create -f tap-service.yaml
kubectl create -f tap-deployment.yaml

# Create the ingress rule for incoming requests.
kubectl create -f tap-ingress.yaml

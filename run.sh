#!/bin/bash


# Script variables
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
TRAINING_GIT_URL="https://github.com/mneedham/data-science-training"
JUPYTER_VERSION="latest"
NEO4J_VERSION="3.5.3"
NEO4J_APOC_VERSION="3.5.0.2"
NEO4J_ALGO_VERSION="3.5.3.1"

# Download training
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
git clone $TRAINING_GIT_URL

# Download neo4j's plugins
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
curl -L https://github.com/neo4j-contrib/neo4j-graph-algorithms/releases/download/$NEO4J_ALGO_VERSION/graph-algorithms-algo-$NEO4J_ALGO_VERSION.jar > ./plugins/graph-algorithms-algo-$NEO4J_ALGO_VERSION.jar
curl -L https://github.com/neo4j-contrib/neo4j-apoc-procedures/releases/download/$NEO4J_APOC_VERSION/apoc-$NEO4J_APOC_VERSION-all.jar > ./plugins/apoc-$NEO4J_APOC_VERSION-all.jar


# Docker part
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
export NEO4J_VERSION=$NEO4J_VERSION 
export JUPYTER_VERSION=$JUPYTER_VERSION
docker rm -f `docker ps -aq -f name=data-science-training*`
docker-compose up



#!/bin/bash


# Script variables
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
TRAINING_GIT_URL="https://github.com/mneedham/data-science-training"
JUPYTER_VERSION="latest"
NEO4J_VERSION="3.5.3"

# Download training
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
if [ ! -d "./data-science-training" ]; then
  git clone $TRAINING_GIT_URL
else
  cd ./data-science-training
  git pull
  cd ..
fi

# Download neo4j's plugins
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
rm -rf ./plugins
mkdir ./plugins
cd ./plugins
URL_GRAPH_ALGO=$(curl -s https://raw.githubusercontent.com/neo4j-contrib/neo4j-graph-algorithms/master/versions.json | jq -r ".[] | select(.neo4j | contains(\"$NEO4J_VERSION\") ) | .jar")
curl -O -s $URL_GRAPH_ALGO


URL_APOC=$(curl -s https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/master/versions.json | jq -r ".[] | select(.neo4j | contains(\"$NEO4J_VERSION\") ) | .jar")
curl -O -s $URL_APOC

cd ..


# Docker part
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
export NEO4J_VERSION="$NEO4J_VERSION-enterprise"
export JUPYTER_VERSION=$JUPYTER_VERSION
docker rm -f `docker ps -aq -f name=data-science-training*`
docker-compose up



#!/bin/bash
# Construire et exécuter le conteneur Docker Squid
docker build -t squid-proxy .
docker run -d --proxy squid-container -p 3128:3128 squid-proxy
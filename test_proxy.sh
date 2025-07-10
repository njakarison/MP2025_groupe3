#!/bin/bash

echo "--------------------------------------"
echo "---- Test de fonctionnement du proxy ----"
echo "--------------------------------------"

# Définir l’adresse IP du proxy (modifie si nécessaire)
PROXY_IP="10.0.2.15"
PROXY_PORT="3128"
SITE_TEST="http://example.com"

echo "Test d'accès à $SITE_TEST via le proxy $PROXY_IP:$PROXY_PORT..."
echo

curl -x "$PROXY_IP:$PROXY_PORT" -I "$SITE_TEST"

echo
echo "Si tu vois un code HTTP 200 ou 301/302 => le proxy fonctionne bien ✅"
echo "Si tu vois un code d'erreur ou rien du tout => vérifier la configuration ❌"
echo "--------------------------------------"

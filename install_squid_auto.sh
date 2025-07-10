#!/bin/bash

echo "--------------------------------------"
echo "---- Installation & Configuration de Squid ----"
echo "--------------------------------------"

# 1. Mise à jour du système
echo "Mise à jour du système..."
apt update -y && apt upgrade -y

# 2. Installation de Squid et apache2-utils
echo "Installation de Squid et apache2-utils..."
apt install -y squid apache2-utils

# 3. Sauvegarde de l'ancien fichier de configuration
echo "Sauvegarde de la configuration originale..."
cp /etc/squid/squid.conf /etc/squid/squid.conf.backup

# 4. Nouvelle configuration de Squid (sans authentification)
echo "Configuration de Squid..."

cat > /etc/squid/squid.conf << EOF
# ----------------------
# Configuration Squid (sans authentification)
# ----------------------

http_port 3128

acl localnet src 10.0.2.0/24

http_access allow localnet
http_access deny all

visible_hostname proxy-server
EOF

# 5. Redémarrage de Squid
echo "Redémarrage de Squid..."
systemctl restart squid

# 6. Vérification de l'installation
echo "--------------------------------------"
echo "🔎 Vérification de l'installation..."
echo "--------------------------------------"

# Vérifier si Squid est installé
if command -v squid > /dev/null; then
    echo "✅ Squid est installé."
else
    echo "❌ Squid n'est pas installé."
fi

# Vérifier si le service Squid tourne
if systemctl is-active --quiet squid; then
    echo "✅ Le service Squid est actif."
else
    echo "❌ Le service Squid ne fonctionne pas."
fi

# Vérifier si le port 3128 est ouvert
if ss -ltnp | grep -q ':3128'; then
    echo "✅ Le port 3128 est bien ouvert."
else
    echo "❌ Le port 3128 n'est pas ouvert."
fi

# Vérifier la configuration
if grep -q "http_port 3128" /etc/squid/squid.conf && grep -q "http_access allow" /etc/squid/squid.conf; then
    echo "✅ Le fichier squid.conf est bien configuré."
else
    echo "❌ Problème dans squid.conf."
fi

echo "--------------------------------------"
echo "🎯 Vérification terminée."
echo "➡️  Configurez votre navigateur avec le proxy : IP_MACHINE:3128"
echo "--------------------------------------"

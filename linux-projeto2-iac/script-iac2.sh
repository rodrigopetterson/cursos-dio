#!/bin/bash
# *********************************************
# * Provisionamento Servidor Apache2  1.0     *
# * Author: Rodrigo Petterson                 *
# * E-Mail: contato@linksky.com.br            *
# * Date: 25-08-2022                          *
# *********************************************

echo "Atualizando o servidor..."
apt-get update
apt-get upgrade -y
apt-get install apache2 -y
apt-get install unzip -y

echo "Baixando e copiando os arquivos da aplicação..."

cd /tmp
wget https://github.com/denilsonbonatti/linux-site-dio/archive/refs/heads/main.zip
unzip main.zip
cd linux-site-dio-main
cp -R * /var/www/html/
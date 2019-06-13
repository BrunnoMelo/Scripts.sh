#!/bin/bash

#Descobrindo Ip Public da Instancia:

IP="$(curl http://169.254.169.254/latest/meta-data/public-ipv4)" 

#Intalando pacotes necessários

sudo apt -y update

sudo apt -y install php-curl php-gd php-mbstring php-xml php-xmlrpc

sudo apt-get -y install mysql-server

sudo apt -y install apache2

sudo apt -y install php libapache2-mod-php php-mysql


#Criando Banco de Dados para wordPress:

sudo mysql << EOF

CREATE DATABASE wordpress;

CREATE USER 'bruno'@'localhost' IDENTIFIED BY 'wordpress';

GRANT ALL ON wordpress.* TO 'bruno'@'localhost';

FLUSH PRIVILEGES;
EOF

#Baixando e configurando  wordPress:

wget https://wordpress.org/latest.tar.gz

sudo mv latest.tar.gz /var/www/

cd /var/www/

sudo tar xpf latest.tar.gz

cd 

sudo chown -R www-data:www-data /var/www/wordpress

sudo cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/wordpress.conf


sudo sed -i '10s/^/        ServerName '$IP'/' /etc/apache2/sites-available/wordpress.conf
 
sudo sed -i '12s/html/wordpress/' /etc/apache2/sites-available/wordpress.conf

sudo sed -i '13s/^/        ServerAlias www.brunowp.com/' /etc/apache2/sites-available/wordpress.conf

sudo a2ensite wordpress.conf

sudo systemctl reload apache2

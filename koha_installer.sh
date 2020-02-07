#!/bin/bash

echo "=================================================="
echo "project : KOHA LMS Installation Script            "
echo "Author  : netwrkspider                            "
echo "Email   : netwrkspider[at]gmail[.]com             "
echo "=================================================="

sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install toilet -y 
toilet -f smblock --filter metal 'KOHA LIBRARY SYSTEM'
toilet -f smblock --filter metal 'Author : netwrkspider'
toilet -f smblock --filter metal '========================='
toilet -f smblock --filter metal 'updating system....'
toilet -f smblock --filter metal 'Installing Apache Web Server...'
sudo apt-get install apache2 -y
toilet -f smblock --filter metal 'installing postfix...'
sudo apt-get install postfix -y
sudo apt-get install libsasl2-2 -y
sudo apt-get install libsasl2-modules -y 
sudo apt-get install ca-certificates -y 
toilet -f smblock --filter metal 'Adding Koha repostory...'
echo deb http://debian.koha-community.org/koha stable main | sudo tee /etc/apt/sources.list.d/koha.list
wget -O- http://debian.koha-community.org/koha/gpg.asc | sudo apt-key add -
toilet -f smblock --filter metal 'updating system....'
sudo apt-get update -y
toilet -f smblock --filter metal 'Installing KOHA Library....'
sudo apt-get install koha-common -y
sudo sed -i 's/INTRAPORT="80"/INTRAPORT="8080"/' /etc/koha/koha-sites.conf
toilet -f smblock --filter metal 'Installing Mysql Server...'
sudo apt-get install mysql-server -y
toilet -f smblock --filter metal 'Configure apache mod..'
sudo a2enmod rewrite
sudo a2enmod cgi
toilet -f smblock --filter metal 'Restarting apache services...'
sudo service apache2 restart
toilet -f smblock --filter metal 'Creating Koha DB libarary...'
sudo koha-create --create-db library
toilet -f smblock --filter metal 'SET Mysql Root password...'
echo "Note Down Mysql Root password.."
sudo mysql_secure_installation
toilet -f smblock --filter metal 'Modifying  Apaching ports.conf.. '
sudo chmod 777 /etc/apache2/ports.conf
sudo echo "Listen 8080" >> /etc/apache2/ports.conf
toilet -f smblock --filter metal 'Apache Mod configuration...'
sudo a2enmod deflate
sudo a2ensite library
sudo a2dissite 000-default.conf
toilet -f smblock --filter metal 'Restarting Apache services'
sudo service apache2 restart
sudo apt install telnet
toilet -f smblock --filter metal 'Check your KOHA password...'
sudo cat /etc/koha/sites/library/koha-conf.xml
toilet -f smblock --filter metal 'Installation Complete!'
echo "Please Access your KOHA application @ http://<YOUR IP Address>:8080"

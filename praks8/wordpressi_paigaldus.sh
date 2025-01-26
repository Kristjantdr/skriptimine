#!/bin/bash
# Wordpressi paigaldus

# Kontrollime, kas skripti käivitab root kasutaja
if [ "$(id -u)" -ne 0 ]; then
    echo "Palun käivitage skript root kasutajana või sudo abil."
    exit 1
fi

#Kontrollime ja paigaldame uuendused
apt update && apt install -y

#kontrollime kas apache2 on installitud.
APACHE2=$(dpkg-query -W -f='${Status}' apache2 2>/dev/null | grep -c 'ok installed')

#kui väärtus võrdub 0
if [ $APACHE2 -eq 0 ]; then

#väljastame teate ja paigaldame teenuse
echo "Paigaldame apache2"
apt install apache2
echo "Apache on paigaldatud"

#kui väärtus võrdub 1
elif [ $APACHE2 -eq 1 ]; then

#väljastame teate, et teenus on paigaldatud
echo "Apache2 on juba paigaldatud"

fi

#kontrollime kas mysql on paigaldatud
MYSQL=$(dpkg-query -W -f='${Status}' mysql-server 2>/dev/null | grep -c 'ok installed')

#kui myswl muutuja väärtus võrdub 0-ga
if [ $MYSQL -eq 0 ]; then

#väljastame teate ja paigaldame teenuse
echo "Paigaldame mysql ja vajalikud lisad"
apt install -y mysql-server
echo "Mysql on paigaldatud!"

#kui mysql muutuja väärtus võrdub 1-ga
elif [ $MYSQL -eq 1 ]; then

#väljastame teate, et mysql on paigaldatud
echo "Mysql on juba paigaldatud!"

fi

#kontrollime kas php on paigaldatud
PHP=$(dpkg-query -W -f='${Status}' php8.1 2>/dev/null |grep -c 'ok installed')

#kui väärtus võrdub 0-ga
if [ $PHP -eq 0 ]; then

#väljastame teate ja paigaldame teenuse
echo "Paigaldame php ja vajalikud lisad"
apt install -y php8.1 libapache2-mod-php8.1 php8.1-mysql
echo "Php on paigaldatud!"

#kui väärtus võrdub 1-ga
elif [ $PHP -eq 1 ]; then

#siis on php paigaldatud
echo "Php on juba paigaldatud!"

fi

#Loome mysql andmebaasi ja kasutaja wordpressi jaoks
echo "Loome MySQL andmebaasi ja kasutaja Wordpressi jaoks"

read -p "Sisestage andmebaasi nimi: " ABnimi
read -p "Sisestage MySQL kasutajanimi: " Knimi
read -s -p "Sisestage MySQL kasutaja parool: " Kparool
read -s -p "Sisestage MySQL root parool: " Rparool

#Käivitame ja lisame andmed mysql
mysql -u root -p"$Rparool" <<MYSQL_SCRIPT
CREATE DATABASE $ABnimi;
CREATE USER '$Knimi'@'localhost' IDENTIFIED BY '$Kparool';
GRANT ALL PRIVILEGES ON $ABnimi.* TO '$Knimi'@'localhost';
FLUSH PRIVILEGES;
MYSQL_SCRIPT

# Kinnitus
echo "Andmebaas ja kasutaja on loodud:"
echo "  - Andmebaas: $ABnimi"
echo "  - Kasutaja: $Knimi"
echo "WordPressi andmebaasi seadistamisel kasutage neid andmeid!"

# Installime WP

echo "Laadime alla ja installime WordPressi..."

cd /tmp || exit
wget https://wordpress.org/latest.tar.gz
tar xzvf latest.tar.gz

# Liigutame WP failid veebikausta

mv wordpress/* /var/www/html/

# Muudame WP failide õigusi

chown -R www-data:www-data /var/www/html/
chmod -R 777 /var/www/html/

# Loome faili  wp-config.php sample failist

cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

# Uuendame wp-config.php andmebaasi andmetega

sed -i "s/database_name_here/$ABnimi/" /var/www/html/wp-config.php
sed -i "s/username_here/$Knimi/" /var/www/html/wp-config.php
sed -i "s/password_here/$Kparool/" /var/www/html/wp-config.php

echo "WordPress on edukalt paigaldatud! Palun minge oma brauserisse ja avage http://192.168.42.75/install.php, et lõpule viia installimine."

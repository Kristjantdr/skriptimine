#!/bin/bash
# Wordpressi paigaldus

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
echo "mysql on paigaldatud!"

#kui mysql muutuja väärtus võrdub 1-ga
elif [ $MYSQL -eq 1 ]; then

#väljastame teate, et mysql on paigaldatud
echo "mysql on juba paigaldatud!"

fi

#kontrollime kas php on paigaldatud
PHP=$(dpkg-query -W -f='${Status}' php8.1 2>/dev/null |grep -c 'ok installed')

#kui väärtus võrdub 0-ga
if [ $PHP -eq 0 ]; then

#väljastame teate ja paigaldame teenuse
echo "Paigaldame php ja vajalikud lisad"
apt install -y php8.1 libapache2-mod-php8.1 php8.1-mysql
echo "php on paigaldatud!"

#kui väärtus võrdub 1-ga
elif [ $PHP -eq 1 ]; then

#siis on php paigaldatud
echo "php on juba paigaldatud!"

fi

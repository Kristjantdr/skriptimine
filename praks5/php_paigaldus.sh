#!/bin/bash
#php paigaldus

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

#kontrollime olemasolu
which php

#lõpetame skripti
fi

#skripti lõpp


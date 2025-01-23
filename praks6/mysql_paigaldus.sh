#!/bin/bash
#mysql paigaldus Ubuntus

#kontrollime kas mysql on paigaldatud
MYSQL=$(dpkg-query -W -f='${Status}' mysql-server 2>/dev/null | grep -c 'ok installed')

#kui myswl muutuja väärtus võrdub 0-ga
if [ $MYSQL -eq 0 ]; then

#väljastame teate ja paigaldame teenuse
echo "Paigaldame mysql ja vajalikud lisad"
apt install -y mysql-server
echo "mysql on paigaldatud!"

#lisame võimaluse kasutada mysql käske ilma kasutaja ja paroolita
#lisame vajaliku konfiguratsioonifaili
touch $HOME/.my.cnf
echo "[client]" >> $HOME/.my.cnf
echo "host = localhost" >> $HOME/.my.cnf
echo "user = root" >> $HOME/.my.cnf
echo "password = qwerty"  >> $HOME/.my.cnf

#kui mysql muutuja väärtus võrdub 1-ga
elif [ $MYSQL -eq 1 ]; then

#väljastame teate, et mysql on paigaldatud
echo "mysql on juba paigaldatud!"

#käivitame ja näitame staatust
service mysql start
service mysql status

#lõpetame skripti
fi

#skripti lõpp

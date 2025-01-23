#!/bin/bash
#phpmyadmin paigaldus Ubuntus

#Uuendame seadet
#sudo apt update -y
#sudo apt upgrade -y 

#kontrollime kas mariadb on paigaldatud
MARIA=$(dpkg-query -W -f='${Status}' mariadb 2>/dev/null | grep -c 'ok installed')

#kui väärtus võrdub 0-ga
if [ $MARIA -eq 0 ]; then

#väljastame teate ja paigaldame teenuse
echo "Paigaldame mariadb ja vajalikud lisad"
apt install mariadb-server-10.6 mariadb-client-10.6
echo "mariadb on paigaldatud!"

#kui väärtus võrdub 1-ga
elif [ $MARIA -eq 1 ]; then

#väljastame teate, et teenus on paigaldatud
echo "mariadb on juba paigaldatud!"
sleep 3

fi

#väljastame teate, et hakkame paigaldama phpmyadmin
echo "Järgmisena paigaldame phpmyadmin"
sleep 3

#kontrollime kas phpmyadmin on juba paigaldatud
#PMA=$(dpkg-query -W -f='${Status}' phpmyadmin 2>/dev/null | grep -c 'ok installed')

#kui väärtus võrdub 0-ga
#if [ $PMA -eq 0 ]; then

#väljastame teate ja paigaldame teenuse
echo "Paigaldame phpmyadmin ja vajalikud lisad"
#apt install phpmyadmin -y
echo "phpmyadmin on paigaldatud"

#kui väärtus võrdub 1-ga
#elif [ $PMA -eq 1 ]; then

#väljastame teate, et teenus on paigaldatud
echo "phpmyadmin on juba paigaldatud!"

#käivitame ja näitame staatust
#service phpmyadmin start
#service phpmyadmin status

#lõpetame skripti
fi

#skripti lõpp

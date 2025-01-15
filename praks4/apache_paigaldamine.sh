#!/bin/bash
#script kontrollib kas apache2 on installitud.
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


#käivitame ja näitame staatust
service apache2 start
service apache2 status

#lõpetame skripti
fi

#skripti lõpp


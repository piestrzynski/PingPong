#!/bin/bash
##################################################
# w pliku ping_url.txt w tym samym katalogu
# wymagane sa domeny do sprawdzenia
# Pliki log 2, mail należy uzupełnić
#
##################################################

# dla pojedycznego adresu sprawdzenie kodow bledow

for z in $(cat ping_url.txt)

do 	
	status=`curl -s -o /dev/null -w "%{http_code}" $z`

	if [ $status = "200" ]
	then	echo "jest OK 200 nic nie rób"
	elif [ $status = "403" ]
	then	echo "403 -$z; `date`" >> pingpong.log
	echo "Być może ok, jest 403"
	elif [ $status = "404" ]
	then	ping -c3 $z > ping-404.log
	whois $z >> ping-404.log
	mail -s "404 dla $z, `date`" "test@test.pl" < ping-404.log
	else
	echo "Status: $status - $z; `date`" >> pingpong.log
	fi
done


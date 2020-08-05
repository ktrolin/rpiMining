#!/bin/bash

#idé: "smart mining"
#1) start script
#2) fetch altcoinvalues from website
#3) compare which is higher
#4) start mining the higher
#5) write log
#6) restart every24h with crontab
#repeat

curl -s 'https://api.thingspeak.com/apps/thinghttp/send_request?api_key=JDHUB2WQAUZ11DCP' > FTCval.txt
curl -s 'https://api.thingspeak.com/apps/thinghttp/send_request?api_key=K2IMIRCBTZV2BM06' > XMGval.txt
FTC=( $(<FTCval.txt) )
XMG=( $(<XMGval.txt) )

killall 1 screen
if [ $(echo "$XMG < $FTC" | bc ) -eq 1 ];
  then
    echo "NSG miner"
	cd /home/pi/nsgminer/
	pwd
	screen -S test -d -m ./nsgminer -o http://hub.miningpoolhub.com:20510 -u ktrolin.worker2 -p password
  else
    echo "CPU miner"
	cd /home/pi/wolf-m7m-cpuminer/
	pwd
	screen -S test -d -m ./minerd -a m7mhash -o stratum+tcp://xmg.suprnova.cc:7128 -u ktrolin.worker1 -p password
fi
echo "Feathercoin value is "$FTC "USD"
echo "Magicoin value is "$XMG "USD"


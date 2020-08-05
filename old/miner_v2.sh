#!/bin/bash

#idé: "smart mining"
#1) start script
#2) fetch altcoinvalues from website
#3) compare which is higher
#4) start mining the higher
#5) write log
#6) restart every24h with crontab
#repeat

~/scripts/FTCprofit.sh
~/scripts/ORBprofit.sh
~/scripts/PXCprofit.sh

FTC=( $( < ~/scripts/transitFiles/FTCprofit.txt) )
ORB=( $( < ~/scripts/transitFiles/ORBprofit.txt) )
PXC=( $( < ~/scripts/transitFiles/PXCprofit.txt) )


killall 1 screen

if [ $(echo "$PXC < $ORB" | bc ) -eq 1 ]
 then
  echo "ORB vs FTC"
  if [ $(echo "$FTC < $ORB" | bc ) -eq 1 ]
   then
    echo "ORB mining hey ho"
	cd /home/pi/nsgminer/
    pwd
    screen -S test -d -m ./nsgminer -o stratum+tcp://s1.theblocksfactory.com:3334 -u ktrolin.worker5 -p password
  fi
 else
  echo "PXC vs FTC"
  if [ $(echo "$FTC < $PXC" | bc ) -eq 1 ]
   then
    echo "PXC hey ho"
	cd /home/pi/nsgminer/
    pwd
    screen -S test -d -m ./nsgminer -o stratum+tcp://stratum.pxc.theblocksfactory.com:3332 -u ktrolin.worker4 -p x
  else
   echo "FTC hey ho"
   	cd /home/pi/nsgminer/
    pwd
    screen -S test -d -m ./nsgminer -o stratum+tcp://s1.theblocksfactory.com:3333 -u ktrolin.worker6 -p password
  fi
fi


#!/bin/bash


PXC=5.5
FTC=7.4
ORB=1.3

if [ $(echo "($PXC < $FTC) < $ORB" | bc ) ];
  then
  
    echo "ORB"
        cd /home/pi/nsgminer/
        pwd
        screen -S test -d -m ./nsgminer -o http://hub.miningpoolhub.com:20510 -u ktrolin.worker2 -p password
  else
    echo "PXC"
        cd /home/pi/wolf-m7m-cpuminer/
        pwd
        screen -S test -d -m ./minerd -a m7mhash -o stratum+tcp://xmg.suprnova.cc:7128 -u ktrolin.worker1 -p password
fi

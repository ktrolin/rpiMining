#!/bin/bash

~/miningScripts/FTCprofit.sh
~/miningScripts/ORBprofit.sh
~/miningScripts/PXCprofit.sh
~/miningScripts/XMGprofit.sh

FTC=( $( < ~/miningScripts/transitFiles/FTCprofit.txt) )
ORB=( $( < ~/miningScripts/transitFiles/ORBprofit.txt) )
PXC=( $( < ~/miningScripts/transitFiles/PXCprofit.txt) )
XMG=( $( < ~/miningScripts/transitFiles/XMGprofit.txt) )

text2+="[{\"dataval\":";
text2+=$FTC;
text2+=", \"coin\":\"FTC\"},";

text2+="{\"dataval\":";
text2+=$ORB;
text2+=", \"coin\":\"ORB\"},";

text2+="{\"dataval\":";
text2+=$PXC;
text2+=", \"coin\":\"PXC\"},";

text2+="{\"dataval\":";
text2+=$XMG;
text2+=", \"coin\":\"XMG\"}]";

destdir=~/miningScripts/transitFiles/json.txt

echo "$text2" > "$destdir"

#Find the coin with most profit

killall 1 screen

#strip json to append most profitable currency
jq 'max_by(.dataval)' ~/miningScripts/transitFiles/json.txt | grep -oP '"\K[^"]+' | sed '1,4d' > ~/miningScripts/transitFiles/appendMineCurrency.txt

#read name of most profitable miner
miner=( $( < ~/miningScripts/transitFiles/appendMineCurrency.txt) )

case "$miner" in
   "FTC") echo "FTC start mining."
   cd ~/nsgminer/
   pwd
   screen -S test -d -m ./nsgminer -o stratum+tcp://s1.theblocksfactory.com:3333 -u ktrolin.worker6 -p password
   ;;
   "ORB") echo "ORB start mining."
   cd ~/nsgminer/
   pwd
   screen -S test -d -m ./nsgminer -o stratum+tcp://s1.theblocksfactory.com:3334 -u ktrolin.worker5 -p password
   ;;
   "PXC") echo "PXC start mining."
   cd ~/nsgminer/
   pwd
   screen -S test -d -m ./nsgminer -o stratum+tcp://stratum.pxc.theblocksfactory.com:3332 -u ktrolin.worker4 -p x
   ;;
   "XMG") echo "XMG start mining."
   cd ~/wolf-m7m-cpuminer/
   pwd
   screen -S test -d -m ./minerd -a m7mhash -o stratum+tcp://minerclaim.net:7008 -u ktrolin.worker1 -p password
   ;;
esac

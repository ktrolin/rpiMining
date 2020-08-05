#!/bin/bash

#~/scripts/FTCprofit_v2.sh
#~/scripts/ORBprofit.sh
#~/scripts/PXCprofit.sh

#FTC=( $( < ~/scripts/transitFiles/FTCprofit.txt) )
#ORB=( $( < ~/scripts/transitFiles/ORBprofit.txt) )
#PXC=( $( < ~/scripts/transitFiles/PXCprofit.txt) )

text2+="[{\"dataval\":";
text2+=143.4;
text2+=", \"coin\":\"FTC\"},";

text2+="{\"dataval\":";
text2+=67.7;
text2+=", \"coin\":\"ORB\"},";

text2+="{\"dataval\":";
text2+=99.45;
text2+=", \"coin\":\"PXC\"}]";

destdir=~/scripts/transitFiles/json.txt

echo "$text2" > "$destdir"

#Find the coin with most profit

killall 1 screen

#strip json to append most profitable currency
jq 'max_by(.dataval)' ~/scripts/transitFiles/json.txt | grep -oP '"\K[^"]+' | sed '1,4d' > ~/scripts/transitFiles/appendMineCurrency.txt
miner=( $( < ~/scripts/transitFiles/appendMineCurrency.txt) )

case "$miner" in
   "FTC") echo "FTC."
   cd ~/nsgminer/
   pwd
   screen -S test -d -m ./nsgminer -o stratum+tcp://s1.theblocksfactory.com:3333 -u ktrolin.worker6 -p password
   ;;
   "ORB") echo "ORB." 
   cd ~/nsgminer/
   pwd
   screen -S test -d -m ./nsgminer -o stratum+tcp://s1.theblocksfactory.com:3334 -u ktrolin.worker5 -p password
   ;;
   "PXC") echo "PXC." 
   cd ~/nsgminer/
   pwd
   screen -S test -d -m ./nsgminer -o stratum+tcp://stratum.pxc.theblocksfactory.com:3332 -u ktrolin.worker4 -p x
   ;;
esac




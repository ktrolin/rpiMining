#!/bin/bash

~/scripts/FTCprofit_v2.sh
~/scripts/ORBprofit.sh
~/scripts/PXCprofit.sh

FTC=( $( < ~/scripts/transitFiles/FTCprofit.txt) )
ORB=( $( < ~/scripts/transitFiles/ORBprofit.txt) )
PXC=( $( < ~/scripts/transitFiles/PXCprofit.txt) )


text2="{\"data\":[";
text2+="{\"FTC\":";
text2+=$FTC;
text2+="},";

text2+="{\"ORB\":";
text2+=$ORB;
text2+="},";

text2+="{\"PXC\":";
text2+=$PXC;
text2+="}";

text2+="]}";

destdir=~/test/json.txt

echo "$text2" > "$destdir"

#Find the coin with most profit
echo "----------------------------------------"
killall 1 screen

#jq '[.data[]] | max' json2.txt > balle.txt GÖR: extraherar key:vale med högsta värdet
#grep -oP '"\K[^"]+' balle.txt GÖR: lyfter ut text inom parentes men verkar som att den gör en extra rad med value
#sed '$d' GÖR: delete last line för att få bor extra rad med value
#jq '[.data[]] | max' json2.txt | grep -oP '"\K[^"]+' | sed '$d'

#strip json to append most profitable currency since jq '[.data[]] | max' json2.txt doesnt wörk
jq '[.data[]] | sort' json.txt | grep -oP '"\K[^"]+' | sed '$d' | sed '$d' | sed '$d' | sed '$d' | sed '$d' | sed 's/ //g' > ~/scripts/transitFiles/appendMineCurrency.txt

miner=( $( < ~/scripts/transitFiles/appendMineCurrency.txt) )
case "$miner" in
   "FTC") echo "FTC."
   cd /home/pi/nsgminer/
   pwd
   screen -S test -d -m ./nsgminer -o stratum+tcp://s1.theblocksfactory.com:3333 -u ktrolin.worker6 -p password
   ;;
   "ORB") echo "ORB." 
   cd /home/pi/nsgminer/
   pwd
   screen -S test -d -m ./nsgminer -o stratum+tcp://s1.theblocksfactory.com:3334 -u ktrolin.worker5 -p password
   ;;
   "PXC") echo "PXC." 
   cd /home/pi/nsgminer/
   pwd
   screen -S test -d -m ./nsgminer -o stratum+tcp://stratum.pxc.theblocksfactory.com:3332 -u ktrolin.worker4 -p x
   ;;
esac


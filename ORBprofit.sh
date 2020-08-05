#!/bin/bash

#matte i bash med bc commandot https://www.lifewire.com/use-the-bc-calculator-in-scripts-2200588 och https://www.geeksforgeeks.org/bc-command-linux-examples/
#var0=25
#var3=`echo "scale=3;
#var1 = 50 / $var0;
#var2 = 3 * var1;
#var2 " \
#| bc`
# alternativt var3=`echo "12+5" | bc`
#echo $var3

echo "----------------------------------------"
echo "Checking ORB profitability..."
#enligt https://bitcoin.stackexchange.com/questions/8568/equation-for-mining-profit
hashRate=3
powerConsumption=5
electricityRate=0.04
blockCoins=1
costHardware=0

curl -s 'https://api.thingspeak.com/apps/thinghttp/send_request?api_key=S9GONNF0B09MONE7' > ~/miningScripts/transitFiles/ORBval.txt
curl -s 'https://api.thingspeak.com/apps/thinghttp/send_request?api_key=N3BIRBV2511D9TW9' | grep -Eo '[+-]?[0-9]+([.][0-9]+)?' > ~/miningScripts/transitFiles/ORBdif.txt
difficulty=( $( < ~/miningScripts/transitFiles/ORBdif.txt) )
conversionRate=( $( < ~/miningScripts/transitFiles/ORBval.txt) )


echo "difficulty "$difficulty ""
echo "conversionRate "$conversionRate " eur"

#The average amount of time (in seconds) to find a single share is:
#hashTime = ((float) $difficulty) * (pow(2.0, 32) / ($hashRate * 1000.0)) ;
hashTime=`echo "scale=3;
var1 = $difficulty * 2^32;
var2 = var1 / ($hashRate * 1000) 
var2 " \
| bc`
echo "hashTime "$hashTime " s"

#powerCostPerYear = 365.25 * 24.0 * $powerConsumption / 1000.0 * $electricityRate;
powerCostPerYear=`echo "scale=3;
var1 = 365.25 * 24 * $powerConsumption / 1000 * $electricityRate;
var1 " \
| bc`
echo "powerCostPerYear "$powerCostPerYear " eur"

#blocksPerYear =  (365.25 * 24.0 * 3600.0) / $hashTime ;
blocksPerYear=`echo "scale=3;
var1 = (365.25 * 24.0 * 3600.0) / $hashTime;
var1 " \
| bc`
echo "blocksPerYear "$blocksPerYear " pc."

#coinsPerYear = $blockCoins * $blocksPerYear;
coinsPerYear=`echo "scale=3;
var1 = $blockCoins * $blocksPerYear;
var1 " \
| bc`
echo "coinsPerYear "$coinsPerYear" pc."

#revenuePerYear = $coinsPerYear * $conversionRate;
revenuePerYear=`echo "scale=3;
var1 = $coinsPerYear * $conversionRate;
var1 " \
| bc`
echo "revenuePerYear "$revenuePerYear" eur"


#profitPerYear = $revenuePerYear - $powerCostPerYear;
profitPerYear=`echo "scale=3;
var1 = $revenuePerYear - $powerCostPerYear;
var1 " \
| bc`
echo "profitPerYear "$profitPerYear" eur"

#netProfit1st = $revenuePerYear - $costHardware - $powerCostPerYear;
netProfit1st=`echo "scale=3;
var1 = $revenuePerYear - $costHardware - $powerCostPerYear;
var1 " \
| bc`
echo "netProfit1st "$netProfit1st

touch ~/miningScripts/transitFiles/ORBprofit.txt
echo "$netProfit1st" > ~/miningScripts/transitFiles/ORBprofit.txt

if [ $(echo "$profitPerYear <= 0" | bc ) -eq 1 ];
	then
	 echo "No Profit :()"
	 breakEvenTime=-1;
	else
	 echo "Profit! :)"
	 breakEvenTime=`echo "scale=10;
	 var1 = $profitPerYear / (365.25 * 24);
	 var2 = $costHardware / var1;
	 var2 " \
	 | bc`
fi

echo "breakEvenTime "$breakEvenTime"hours"


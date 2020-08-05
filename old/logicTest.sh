#!/bin/bash

profitPerYear=-34
costHardware=39

if [ $(echo "$profitPerYear <= 0" | bc ) -eq 1 ]; 
then
 echo "lower"
 breakEvenTime=-1;
else
 echo "higher"
 breakEvenTime=`echo "scale=10;
 var1 = $profitPerYear / (365.25 * 24 * 3600);
 var2 = $costHardware / var1;
 var2 " \
 | bc`
fi



echo $breakEvenTime

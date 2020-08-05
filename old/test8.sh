#!/bin/bash


PXC=5.5
FTC=8.4
ORB=7.3



array = ($PXC, $FTC, $ORB)


${array[0]}

for var in $array
do
   echo $var
done

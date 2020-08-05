#!/bin/bash 
var0="100"
echo "var0: $var0"

function fun1
{
echo "scale=3; 
var1 = 10;
var2 = var1 * $var0;
var2 " \
| bc
}

fres=$(fun1)			#append output from function fun1 to var fres
echo "fres: "$fres

var10=$(/home/pi/scripts./funcScript1 $fres);
echo "var10: "$var10;

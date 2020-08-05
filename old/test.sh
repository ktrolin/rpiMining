#!/bin/bash

var3=3
var4=2

number_one () {
 var0=`echo "scale=2;
 var1 = $var3 * $1;
 var2 = var1 / $var4
 var2 " \
 | bc`
}

number_one 2
echo "var0 is" $var0

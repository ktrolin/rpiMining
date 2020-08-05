#!/bin/bash
echo "scale=3; 
var1 = 6.5 / 2.7;
var2 = 14 * var1;
var2 *= $1;
var2 " \
| bc


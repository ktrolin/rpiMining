#!/bin/bash


PXC=5.5
FTC=8.4
ORB=7.3


if [ $(echo "$PXC < $ORB" | bc ) -eq 1 ]
 then
  echo "ORB vs FTC"
  if [ $(echo "$FTC < $ORB" | bc ) -eq 1 ]
   then
    echo "ORB"
    pwd
  fi
 else
  echo "PXC vs FTC"
  if [ $(echo "$FTC < $PXC" | bc ) -eq 1 ]
   then
    echo "PXC"
  else
   echo "FTC"
  fi
fi

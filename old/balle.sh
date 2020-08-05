#!/bin/bash
input="PXCdif.txt"
while IFS= read -r var
do
  echo "$var"
done < "$input"

#!/bin/bash
if [ "$EUID" -ne 0 ]
        then echo "Please run as root"
else
apt update -y
wget http://download.oracle.com/berkeley-db/db-4.8.30.NC.tar.gz
sudo tar -xzvf db-4.8.30.NC.tar.gz
cd db-4.8.30.NC/build_unix
sudo ../dist/configure --enable-cxx
sudo make
sudo make install
export CPATH="/usr/local/BerkeleyDB.4.8/include"
export LIBRARY_PATH="/usr/local/BerkeleyDB.4.8/lib"

printf "To use type ./minerd with any options you want while in the cpuminer-mult$
printf "For example ./minerd -a cryptonight -o stratum+tcp://xmr-usa.dwarfpool.co$

fi


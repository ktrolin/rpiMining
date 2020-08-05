#!/bin/bash

#CreatePackageFromPPA
#hemsida https://wiki.debian.org/CreatePackageFromPPA

#Install the Debian SDK
sudo apt-get install devscripts build-essential

sudo su
echo "deb-src http://ppa.launchpad.net/gridcoin/gridcoin-stable/ubuntu trusty main" > /etc/apt/sources.list.d/gridcoin.list

apt-key adv --keyserver keyserver.ubuntu.com --recv-keys DBB231E7B333BDB6F6CCA46BD56E6F37B99D3486

#Install the package source and build the package
#All of this is possible with the magical command. As normal user:
exit
sudo apt-get update
sudo apt-get install gridcoinresearchd


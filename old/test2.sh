#!/bin/bash

#idé: "smart mining"
#1) start script
#2) fetch altcoinvalues from website
#3) compare which is higher
#4) start mining the higher
#5) write log
#6) restart every24h with crontab
#repeat

curl -s 'http://api.feathercoin.com/?output=eur&amount=1&json=1' > jsonValFTC.txt
curl -s 'http://api.feathercoin.com/?output=stats' > jsonDifFTC.txt
#Returns the following in JSON
#currblk – Current block number
#khs – Current Hashrate in Kh/s
#retblk – Next retarget block number
#blkstoret – Blocks to next retarget
#exptimeperblk – Expected time per block
#nowdiff – Current difficulty
#nextdiff – Expected next difficulty
#timetoret – Time to retarget in second
#days – Days till next retarget
#hours – Hours till retarget after removing days
#min – Minutes till retarget after removing hours and days
#sec – Seconds till retarget after removing hours, days and minutes
#totcm – Total number of Feathercoins

FTCdiff=($(jq '.nowdiff' jsonDifFTC.txt))
FTCval=($(jq '.eur' jsonValFTC.txt))


echo "Feathercoin difficulty is "$FTCdiff ""
echo "Feathercoin value is "$FTCval "euros"


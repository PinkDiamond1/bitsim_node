#!/bin/bash

for i in $(seq 1 $N_PEERS); 
do 
  PEER=$(dig +short node$i);
  echo "$PEER";
  echo "addnode=${PEER}:18444" >> .bitcoin/bitcoin.conf
  
done
echo 'finished setting up bitcoin.conf file'
./bitcoind -regtest


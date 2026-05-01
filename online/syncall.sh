#!/bin/bash

read -p "Enter Lxplus username: " ACCOUNT

SRCPATH="/home/daq/CAEN_Janus_5202_Win"
DSTPATH="/eos/experiment/newtile/beamtests/26_05_t10/fers_daq"
SFSPATH="/home/daq/eos_temp_fers"

echo "Mounting $SFSPATH into $DSTPATH (may fail if already mounted)"
mkdir -p $SFSPATH
sshfs $ACCOUNT"@lxplus.cern.ch:"$DSTPATH $SFSPATH
echo "---"

echo "Starting live sync between local:"
echo "$SRCPATH"
echo "and remote (is it mounted?):"
echo "$SFSPATH (--> $DSTPATH)"
echo "Kill the process to interrupt"
echo "---"

i=0
while true
do

trap "exit" SIGINT

echo "Iteration number $i..."
i=$(($i + 1))

rsync -avz $SRCPATH/* $SFSPATH/. > /dev/null

echo "---"

echo "Done"

echo "---"

sleep 1

done

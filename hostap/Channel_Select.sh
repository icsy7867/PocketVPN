#!/bin/bash

#Initialize variables. Assumes your key in hostapd.conf is "channel" and not "Channel"

#ARRAY=()
#declare -a ARRAY
CONFIG_FILE=/etc/hostapd/hostapd.conf
TARGET_KEY=channel

#Get frequencies of neighboring WIFI
Command=$(iwlist wlan0 scan | grep Frequency:2.4 | sort | sort -n)
#echo "$Command"

ARRAY[1]=$(echo "$Command" | grep -c -o '2.412 GHz')
ARRAY[2]=$(echo "$Command" | grep -c -o '\(Channel 2\)')
ARRAY[3]=$(echo "$Command" | grep -c -o '\(Channel 3\)')
ARRAY[4]=$(echo "$Command" | grep -c -o '\(Channel 4\)')
ARRAY[5]=$(echo "$Command" | grep -c -o '\(Channel 5\)')
ARRAY[6]=$(echo "$Command" | grep -c -o '\(Channel 6\)')
ARRAY[7]=$(echo "$Command" | grep -c -o '\(Channel 7\)')
ARRAY[8]=$(echo "$Command" | grep -c -o '\(Channel 8\)')
ARRAY[9]=$(echo "$Command" | grep -c -o '\(Channel 9\)')
ARRAY[10]=$(echo "$Command" | grep -c -o '\(Channel 10\)')
#ARRAY[11]=$(echo "$Command" | grep -c -o '\(Channel 11\)')

#Get frequencies of neighboring WIFI
Command=$(iwlist wlan0 scan | grep Frequency:2.4 | sort | sort -n)
#echo "$Command"

ARRAY[1]=$((ARRAY[1]+$(echo "$Command" | grep -c -o '2.412 GHz')))
ARRAY[2]=$((ARRAY[2]+$(echo "$Command" | grep -c -o '\(Channel 2\)')))
ARRAY[3]=$((ARRAY[3]+$(echo "$Command" | grep -c -o '\(Channel 3\)')))
ARRAY[4]=$((ARRAY[4]+$(echo "$Command" | grep -c -o '\(Channel 4\)')))
ARRAY[5]=$((ARRAY[5]+$(echo "$Command" | grep -c -o '\(Channel 5\)')))
ARRAY[6]=$((ARRAY[6]+$(echo "$Command" | grep -c -o '\(Channel 6\)')))
ARRAY[7]=$((ARRAY[7]+$(echo "$Command" | grep -c -o '\(Channel 7\)')))
ARRAY[8]=$((ARRAY[8]+$(echo "$Command" | grep -c -o '\(Channel 8\)')))
ARRAY[9]=$((ARRAY[9]+$(echo "$Command" | grep -c -o '\(Channel 9\)')))
ARRAY[10]=$((ARRAY[10]+$(echo "$Command" | grep -c -o '\(Channel 10\)')))
#ARRAY[11]=$((ARRAY[11]+$(echo "$Command" | grep -c -o '\(Channel 11\)')))

#Echo posistion of smallest entry
Position=$(echo "${ARRAY[@]}" | tr -s ' ' '\n' | awk '{print($0" "NR)}' | sort -g -k1,1 | head -1 | cut -f2 -d' ')

#For testing, printing the array and positions channel variable
#printf '%s\n' "${ARRAY[@]}"
#echo "$Position"

#Replace channel in hostapd.conf
sed -i "s/\($TARGET_KEY *= *\).*/\1$Position/" $CONFIG_FILE

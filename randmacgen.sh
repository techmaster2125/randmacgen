#!/bin/bash

############################
# Author: Techmaster	   #
# Requirements: macchanger #
############################

## Bold colors
bold_red="$(tput bold; tput setaf 1)"
nc="$(tput sgr0)"

## Print warning
echo "${bold_red}***Put your interface down; else there is a risk of getting curropt NIC***${nc}"

## Putting down interface
echo "Enter your wireless interface"
read -p "=> " iface
echo ""
echo -e "Executing command: sudo ifconfig ${iface} down"
sudo ifconfig $iface down

## Get valid macs and store them
macchanger -l > mac-vendors.txt

## Generate a valid mac
vmac=$(shuf -n 1 mac-vendors.txt | awk '{ printf $3 }')
rmac=$(printf "%02x:%02x:%02x" $[RANDOM%256] $[RANDOM%256] $[RANDOM%256])
nmac="$vmac:$rmac"

## Set the new mac
echo -e "\033[0;32mChangin MAC to => $nmac\033[0m"
echo ""
sudo macchanger -m $nmac wlan0

## setting iface back to up
sudo ifconfig wlan0 up

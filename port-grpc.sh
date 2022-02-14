#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(wget -qO- ifconfig.me/ip);
echo "Checking VPS"
clear

vl="$(cat ~/log-install.txt | grep -w "XRAY VLESS GRPC" | cut -d: -f2|sed 's/ //g')"
echo -e "      Change Port $vl"
read -p "New Port XRAY Vless Grpc: " vl1
if [ -z $vl1 ]; then
echo "Please Input Port"
exit 0
fi

cek=$(netstat -nutlp | grep -w $vl1)
if [[ -z $cek ]]; then
sed -i "s/$vl/$vl1/g" /etc/xray-mini/vless-gprc.json
sed -i "s/- XRAY VLESS GRPC         : $vl/- XRAY VLESS GRPC         : $vl1/g" /root/log-install.txt
systemctl stop xray-mini-gprc.service > /dev/null
systemctl enable xray-mini-gprc.service > /dev/null
systemctl start xray-mini-gprc.service > /dev/null
echo -e "\e[032;1mPort $vl1 modified successfully\e[0m"
else
echo "Port $vl1 is used"
fi
read -n 1 -s -r -p "Press any key to back on menu"
menu
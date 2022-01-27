#!/bin/bash
MYIP=$(wget -qO- ipinfo.io/ip);
echo "Checking VPS"

function user-monitor() {
	clear
	echo -n > /tmp/other.txt
	data=($(cat /etc/rare/v2ray/clients.txt | awk '{print $1}'));
	echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\E[0;100;33m     • V2RAY USER MONITOR •        \E[0m"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo ""
	for akun in "${data[@]}"
	do
	if [[ -z "$akun" ]]; then
	akun="tidakada"
	fi
	echo -n > /tmp/ipvmess.txt
	data2=( `netstat -anp | grep ESTABLISHED | grep tcp6 | grep v2ray | awk '{print $5}' | cut -d: -f1 | sort | uniq`);
	for ip in "${data2[@]}"
	do
	jum=$(cat /var/log/v2ray/access.log | grep -w $akun | awk '{print $3}' | cut -d: -f1 | grep -w $ip | sort | uniq)
    if [[ "$jum" = "$ip" ]]; then
	echo "$jum" >> /tmp/ipvmess.txt
	else
	echo "$ip" >> /tmp/other.txt
	fi
	jum2=$(cat /tmp/ipvmess.txt)
	sed -i "/$jum2/d" /tmp/other.txt > /dev/null 2>&1
	done
	jum=$(cat /tmp/ipvmess.txt)
	if [[ -z "$jum" ]]; then
	echo > /dev/null
	else
	jum2=$(cat /tmp/ipvmess.txt | nl)
	echo "user : $akun";
	echo "$jum2";
    echo -e  "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
	fi
	rm -rf /tmp/ipvmess.txt
	done
	oth=$(cat /tmp/other.txt | sort | uniq | nl)
	echo "other";
	echo "$oth";
	echo -e  "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
	rm -rf /tmp/other.txt
	echo -e ""
    read -n 1 -s -r -p "Press any key to back on menu"
    v2ray-menu     
#!/bin/bash
MYIP=$(wget -qO- ipinfo.io/ip);
echo "Checking VPS"

function extend-user() {
	clear
	echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\E[0;100;33m      • EXTEND V2RAY USER •        \E[0m"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo ""
	read -p "Username : " user
	if ! grep -qw "$user" /etc/rare/v2ray/clients.txt; then
		echo -e ""
		echo -e "User \e[31m$user\e[0m does not exist"
        echo ""
        echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
        echo ""
        read -n 1 -s -r -p "Press any key to back on menu"
        v2ray-menu
	fi
	read -p "Duration (day) : " extend
	uuid=$(cat /etc/rare/v2ray/clients.txt | grep -w $user | awk '{print $2}')
	exp_old=$(cat /etc/rare/v2ray/clients.txt | grep -w $user | awk '{print $3}')
	diff=$((($(date -d "${exp_old}" +%s)-$(date +%s))/(86400)))
	duration=$(expr $diff + $extend + 1)
	exp_new=$(date -d +${duration}days +%Y-%m-%d)
	exp=$(date -d "${exp_new}" +"%d %b %Y")
	sed -i "/\b$user\b/d" /etc/rare/v2ray/clients.txt
	echo -e "$user\t$uuid\t$exp_new" >> /etc/rare/v2ray/clients.txt
	clear
	echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\E[0;100;33m   • V2RAY USER INFORMATION •      \E[0m"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo ""
	echo -e "Username     : $user"
	echo -e "Expired date : $exp"
	echo -e ""
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo ""
    read -n 1 -s -r -p "Press any key to back on menu"
    v2ray-menu   
}
#!/bin/bash
MYIP=$(wget -qO- ipinfo.io/ip);
echo "Checking VPS"

function show-config() {
	echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\E[0;100;33m      • V2RAY USER CONFIG •        \E[0m"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e ""
	read -p "User : " user
	if ! grep -qw "$user" /etc/rare/v2ray/clients.txt; then
		echo -e ""
		echo -e "User \e[31m$user\e[0m does not exist"
		echo -e ""
        read -n 1 -s -r -p "Press any key to back on menu"
        v2ray-menu
	fi
    tls="$(cat ~/log-install.txt | grep -w "V2RAY VLESS TLS SPLICE" | cut -d: -f2|sed 's/ //g')"
    link=$(cat /etc/rare/config-user/${user})
	uuid=$(cat /etc/rare/v2ray/clients.txt | grep -w "$user" | awk '{print $2}')
	domain=$(cat /etc/rare/xray/domain)
	exp=$(cat /etc/rare/v2ray/clients.txt | grep -w "$user" | awk '{print $3}')
	exp_date=$(date -d"${exp}" "+%d %b %Y")

	clear
	echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\E[0;100;33m   • V2RAY USER INFORMATION •      \E[0m"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"      
	echo -e ""
	echo -e " Username      : $user"
	echo -e " Expired date  : $exp_date"
	echo -e " Ip Vps        : $MYIP"
    echo -e " Domain        : $domain"
    echo -e " PORT          : $tls"
    echo -e " UUID/PASSWORD : $uuid"
	echo -e ""
    echo -e " Link url OPENWRT/V2rayN PC: https://${domain}/s/${uuid}"
	echo -e ""
	echo -e " Link url ASUS Clash: https://${domain}/s/${user}"  
    echo -e ""
    echo -e " Config :"
	echo -e " $link"  
	echo -e ""
	echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo ""
    read -n 1 -s -r -p "Press any key to back on menu"
    v2ray-menu    
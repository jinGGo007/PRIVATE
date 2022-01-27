#!/bin/bash
MYIP=$(wget -qO- ipinfo.io/ip);
echo "Checking VPS"


function delete-user() {
	clear
	echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\E[0;100;33m      • DELETE V2RAY USER •        \E[0m"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e ""  
	read -p "Username : " user
	echo -e ""
	if ! grep -qw "$user" /etc/rare/v2ray/clients.txt; then
		echo -e ""
        echo -e "User \e[31m$user\e[0m does not exist"
        echo ""
        echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
        echo ""
        read -n 1 -s -r -p "Press any key to back on menu"
        v2ray-menu
	fi
    rm /etc/rare/config-url/${user}
	uuid="$(cat /etc/rare/v2ray/clients.txt | grep -w "$user" | awk '{print $2}')"
	cat /etc/rare/v2ray/conf/02_VLESS_TCP_inbounds.json | jq 'del(.inbounds[0].settings.clients[] | select(.id == "'${uuid}'"))' > /etc/rare/v2ray/conf/02_VLESS_TCP_inbounds_tmp.json
	mv -f /etc/rare/v2ray/conf/02_VLESS_TCP_inbounds_tmp.json /etc/rare/v2ray/conf/02_VLESS_TCP_inbounds.json
    cat /etc/rare/v2ray/conf/03_VLESS_WS_inbounds.json | jq 'del(.inbounds[0].settings.clients[] | select(.id == "'${uuid}'"))' > /etc/rare/v2ray/conf/03_VLESS_WS_inbounds_tmp.json
	mv -f /etc/rare/v2ray/conf/03_VLESS_WS_inbounds_tmp.json /etc/rare/v2ray/conf/03_VLESS_WS_inbounds.json
    cat /etc/rare/v2ray/conf/04_trojan_TCP_inbounds.json | jq 'del(.inbounds[0].settings.clients[] | select(.password == "'${uuid}'"))' > /etc/rare/v2ray/conf/04_trojan_TCP_inbounds_tmp.json
	mv -f /etc/rare/v2ray/conf/04_trojan_TCP_inbounds_tmp.json /etc/rare/v2ray/conf/04_trojan_TCP_inbounds.json		
    cat /etc/rare/v2ray/conf/05_VMess_WS_inbounds.json | jq 'del(.inbounds[0].settings.clients[] | select(.id == "'${uuid}'"))' > /etc/rare/v2ray/conf/05_VMess_WS_inbounds_tmp.json
	mv -f /etc/rare/v2ray/conf/05_VMess_WS_inbounds_tmp.json /etc/rare/v2ray/conf/05_VMess_WS_inbounds.json
    sed -i "/\b$user\b/d" /etc/rare/v2ray/clients.txt
    rm /etc/rare/config-user/${user}
    rm /etc/rare/config-url/${uuid}
	systemctl restart v2ray.service
    echo -e "\033[32m[Info]\033[0m v2ray Start Successfully !"
    echo ""
	echo -e "User \e[32m$user\e[0m deleted Successfully !"
	echo ""
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo ""
    read -n 1 -s -r -p "Press any key to back on menu"
    v2ray-menu 
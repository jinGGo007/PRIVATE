#!/bin/bash
MYIP=$(wget -qO- ipinfo.io/ip);
echo "Checking VPS"

function change-port() {
	clear
    xtls="$(cat ~/log-install.txt | grep -w "XRAY VLESS XTLS SPLICE" | cut -d: -f2|sed 's/ //g')"
	echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\E[0;100;33m       • CHANGE PORT XRAY •        \E[0m"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e ""
	echo -e "Change Port XRAY TCP XTLS: $xtls"
	echo -e ""
	read -p "New Port XRAY TCP XTLS: " xtls1
	if [ -z $xtls1 ]; then
	echo "Please Input Port"
	echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo ""
    read -n 1 -s -r -p "Press any key to back on menu"
    change-port  	
	fi
	cek=$(netstat -nutlp | grep -w $xtls1)
    if [[ -z $cek ]]; then
    sed -i "s/$xtls/$xtls1/g" /etc/rare/xray/conf/02_VLESS_TCP_inbounds.json
    sed -i "s/   - XRAY VLESS XTLS SPLICE  : $xtls/   - XRAY VLESS XTLS SPLICE : $xtls1/g" /root/log-install.txt
    sed -i "s/   - XRAY VLESS XTLS DIRECT  : $xtls/   - XRAY VLESS XTLS DIRECT  : $xtls1/g" /root/log-install.txt
    sed -i "s/   - XRAY VLESS WS TLS       : $xtls/   - XRAY VLESS WS TLS       : $xtls1/g" /root/log-install.txt
	sed -i "s/   - XRAY TROJAN TLS         : $xtls/   - XRAY TROJAN TLS         : $xtls1/g" /root/log-install.txt
    sed -i "s/   - XRAY VMESS TLS          : $xtls/   - XRAY VMESS TLS          : $xtls1/g" /root/log-install.txt
    iptables -D INPUT -m state --state NEW -m tcp -p tcp --dport $xtls -j ACCEPT
    iptables -D INPUT -m state --state NEW -m udp -p udp --dport $xtls -j ACCEPT
    iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport $xtls1 -j ACCEPT
    iptables -I INPUT -m state --state NEW -m udp -p udp --dport $xtls1 -j ACCEPT
    iptables-save > /etc/iptables.up.rules
    iptables-restore -t < /etc/iptables.up.rules
    netfilter-persistent save > /dev/null
    netfilter-persistent reload > /dev/null
    systemctl restart xray > /dev/null
    echo -e "\033[32m[Info]\033[0m xray Start Successfully !"
    echo ""
    echo -e "\e[032;1mPort $xtls1 modified Successfully !\e[0m"
	echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo ""
    read -n 1 -s -r -p "Press any key to back on menu"
    xray-menu    
    else
    echo "Port $xtls1 is used"
	echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo ""
    read -n 1 -s -r -p "Press any key to back on menu"
    change-port      
    fi
}
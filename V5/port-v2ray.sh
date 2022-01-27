#!/bin/bash
MYIP=$(wget -qO- ipinfo.io/ip);
echo "Checking VPS"

function change-port() {
	clear
    tls="$(cat ~/log-install.txt | grep -w "V2RAY VLESS TLS SPLICE" | cut -d: -f2|sed 's/ //g')"
	echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\E[0;100;33m      • CHANGE PORT V2RAY •        \E[0m"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e ""
	echo -e "Change Port V2RAY TCP TLS: $tls"
	echo -e ""
	read -p "New Port V2RAY TCP TLS: " tls1
	if [ -z $tls1 ]; then
	echo "Please Input Port"
	echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo ""
    read -n 1 -s -r -p "Press any key to back on menu"
    change-port 
	fi
	cek=$(netstat -nutlp | grep -w $tls1)
    if [[ -z $cek ]]; then
    sed -i "s/$tls/$tls1/g" /etc/rare/v2ray/conf/02_VLESS_TCP_inbounds.json
    sed -i "s/   - V2RAY VLESS TLS SPLICE  : $tls/   - V2RAY VLESS TLS SPLICE  : $tls1/g" /root/log-install.txt
    sed -i "s/   - V2RAY VLESS TLS DIRECT  : $tls/   - V2RAY VLESS TLS DIRECT  : $tls1/g" /root/log-install.txt
    sed -i "s/   - V2RAY VLESS WS TLS      : $tls/   - V2RAY VLESS WS TLS      : $tls1/g" /root/log-install.txt
    sed -i "s/   - V2RAY TROJAN TLS        : $tls/   - V2RAY TROJAN TLS        : $tls1/g" /root/log-install.txt
    sed -i "s/   - V2RAY VMESS TLS         : $tls/   - V2RAY VMESS TLS         : $tls1/g" /root/log-install.txt
    iptables -D INPUT -m state --state NEW -m tcp -p tcp --dport $tls -j ACCEPT
    iptables -D INPUT -m state --state NEW -m udp -p udp --dport $tls -j ACCEPT
    iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport $tls1 -j ACCEPT
    iptables -I INPUT -m state --state NEW -m udp -p udp --dport $tls1 -j ACCEPT
    iptables-save > /etc/iptables.up.rules
    iptables-restore -t < /etc/iptables.up.rules
    netfilter-persistent save > /dev/null
    netfilter-persistent reload > /dev/null
    systemctl restart v2ray > /dev/null
    echo -e "\033[32m[Info]\033[0m v2ray Start Successfully !"
    echo ""
    echo -e "\e[032;1mPort $tls1 modified Successfully !\e[0m"
	echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo ""
    read -n 1 -s -r -p "Press any key to back on menu"
    v2ray-menu    
    else
    echo "Port $tls1 is used"
	echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo ""
    read -n 1 -s -r -p "Press any key to back on menu"
    change-port    
    fi
}
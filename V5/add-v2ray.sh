#!/bin/bash
MYIP=$(wget -qO- ipinfo.io/ip);
echo "Checking VPS"

function add-user() {
	clear
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\E[0;100;33m       • ADD V2RAY USER •          \E[0m"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo ""      
	read -p "Username : " user
	if grep -qw "$user" /etc/rare/v2ray/clients.txt; then
		echo -e ""
		echo -e "User \e[31m$user\e[0m already exist"
		echo -e ""
		echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
        echo ""
        read -n 1 -s -r -p "Press any key to back on menu"
        v2ray-menu
	fi
    read -p "BUG TELCO : " BUG
	read -p "Duration (day) : " duration
	uuid=$(cat /proc/sys/kernel/random/uuid)
	exp=$(date -d +${duration}days +%Y-%m-%d)
	expired=$(date -d "${exp}" +"%d %b %Y")
	domain=$(cat /etc/rare/xray/domain)
	tls="$(cat ~/log-install.txt | grep -w "V2RAY VLESS TLS SPLICE" | cut -d: -f2|sed 's/ //g')"
	email=${user}@${domain}
    cat>/etc/rare/v2ray/tls.json<<EOF
      {
       "v": "2",
       "ps": "${user}@IanVPN",
       "add": "${BUG}.${domain}",
       "port": "${tls}",
       "id": "${uuid}",
       "aid": "0",
       "scy": "auto",
       "net": "ws",
       "type": "none",
       "host": "${BUG}",
       "path": "/v2rayvws",
       "tls": "tls",
       "sni": "${BUG}"
}
EOF
    vmess_base641=$( base64 -w 0 <<< $vmess_json1)
    vmesslink1="vmess://$(base64 -w 0 /etc/rare/v2ray/tls.json)"
	echo -e "${user}\t${uuid}\t${exp}" >> /etc/rare/v2ray/clients.txt
    cat /etc/rare/v2ray/conf/02_VLESS_TCP_inbounds.json | jq '.inbounds[0].settings.clients += [{"id": "'${uuid}'","add": "'${domain}'","flow": "xtls-rprx-direct","email": "'${email}'"}]' > /etc/rare/v2ray/conf/02_VLESS_TCP_inbounds_tmp.json
	mv -f /etc/rare/v2ray/conf/02_VLESS_TCP_inbounds_tmp.json /etc/rare/v2ray/conf/02_VLESS_TCP_inbounds.json
    cat /etc/rare/v2ray/conf/03_VLESS_WS_inbounds.json | jq '.inbounds[0].settings.clients += [{"id": "'${uuid}'","email": "'${email}'"}]' > /etc/rare/v2ray/conf/03_VLESS_WS_inbounds_tmp.json
	mv -f /etc/rare/v2ray/conf/03_VLESS_WS_inbounds_tmp.json /etc/rare/v2ray/conf/03_VLESS_WS_inbounds.json
    cat /etc/rare/v2ray/conf/04_trojan_TCP_inbounds.json | jq '.inbounds[0].settings.clients += [{"password": "'${uuid}'","email": "'${email}'"}]' > /etc/rare/v2ray/conf/04_trojan_TCP_inbounds_tmp.json
	mv -f /etc/rare/v2ray/conf/04_trojan_TCP_inbounds_tmp.json /etc/rare/v2ray/conf/04_trojan_TCP_inbounds.json
    cat /etc/rare/v2ray/conf/05_VMess_WS_inbounds.json | jq '.inbounds[0].settings.clients += [{"id": "'${uuid}'","alterId": 0,"add": "'${domain}'","email": "'${email}'"}]' > /etc/rare/v2ray/conf/05_VMess_WS_inbounds_tmp.json
	mv -f /etc/rare/v2ray/conf/05_VMess_WS_inbounds_tmp.json /etc/rare/v2ray/conf/05_VMess_WS_inbounds.json
	cat <<EOF >>"/etc/rare/config-user/${user}"
vless://$uuid@$BUG.$domain:$tls?flow=xtls-rprx-splice&encryption=none&security=tls&sni=$BUG&type=tcp&headerType=none&host=$BUG#$user@IanVPN
vless://$uuid@$BUG.$domain:$tls?flow=xtls-rprx-direct&encryption=none&security=tls&sni=$BUG&type=tcp&headerType=none&host=$BUG#$user@IanVPN
vless://$uuid@$BUG.$domain:$tls?encryption=none&security=tls&sni=$BUG&type=ws&host=$BUG&path=/v2rayws#$user@IanVPN
trojan://$uuid@$BUG.$domain:$tls?sni=$BUG#$user@IanVPN
${vmesslink1}
EOF

    systemctl restart v2ray.service
    echo -e "\033[32m[Info]\033[0m v2ray Start Successfully !"
    sleep 2
    clear
	echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\E[0;100;33m   • V2RAY USER INFORMATION •      \E[0m"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"  
	echo -e ""
	echo -e " Username      : $user"
	echo -e " Expired date  : $expired"
    echo -e " Jumlah Hari   : $duration Hari"
    echo -e " PORT          : $tls"
    echo -e " UUID/PASSWORD : $uuid"
	echo -e ""
	echo -e " Pantang Larang IANVPN"
	echo -e " ‼️Aktiviti Berikut Adalah Dilarang"
    echo -e " (ID akan di ban tanpa notis & tiada refund)"
	echo -e " ❌PS4"
	echo -e " ❌Porn"
	echo -e " ❌Ddos Server"
	echo -e " ❌Mining Bitcoins"
	echo -e " ❌Abuse Usage"
	echo -e " ❌Multi-Login ID"
	echo -e " ❌Sharing Premium Config"	
	echo -e ""
    echo -e " Ip Vps        : $MYIP"
    echo -e " Domain        : $domain"
	echo -e " Bug Domain    : $BUG"
    echo -e ""
	echo -e " Link VLESS SPLICE: vless://$uuid@$BUG.$domain:$tls?flow=xtls-rprx-splice&encryption=none&security=tls&sni=$BUG&type=tcp&headerType=none&host=$BUG#$user@IanVPN"
    echo -e ""
    echo -e " Link VLESS DIRECT: vless://$uuid@$BUG.$domain:$tls?flow=xtls-rprx-direct&encryption=none&security=tls&sni=$BUG&type=tcp&headerType=none&host=$BUG#$user@IanVPN"
    echo -e ""
	echo -e " Link VLESS WS: vless://$uuid@$BUG.$domain:$tls?encryption=none&security=tls&sni=$BUG&type=ws&host=$BUG&path=/v2rayws#$user@IanVPN"
    echo -e ""
	echo -e " Link TROJAN: trojan://$uuid@$BUG.$domain:$tls?sni=$BUG#$user@IanVPN"
    echo -e ""
    echo -e " Link VMESS TLS: ${vmesslink1}"
	echo -e ""
    echo -e " Link url OPENWRT/V2rayN PC: https://${domain}/s/${uuid}"
	echo -e ""
	echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo ""
    read -n 1 -s -r -p "Press any key to back on menu"
    menu  
}

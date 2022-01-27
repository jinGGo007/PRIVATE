#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(wget -qO- icanhazip.com);
echo "Checking VPS"
clear

}
function add-user() {
	clear
    
	read -p "Username  : " user
	if grep -qw "$user" /etc/rare/xray/clients.txt; then
		echo -e ""
		echo -e "User \e[31m$user\e[0m already exist"
		echo -e ""
		echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
        echo ""
        read -n 1 -s -r -p "Press any key to back on menu"
        xray-menu
	fi
    read -p "BUG TELCO : " BUG
	read -p "Duration (day) : " duration
	uuid=$(cat /proc/sys/kernel/random/uuid)
	exp=$(date -d +${duration}days +%Y-%m-%d)
	expired=$(date -d "${exp}" +"%d %b %Y")
	domain=$(cat /etc/rare/xray/domain)
	xtls="$(cat ~/log-install.txt | grep -w "XRAY VLESS XTLS SPLICE" | cut -d: -f2|sed 's/ //g')"
	email=${user}@${domain}
    cat>/etc/rare/xray/tls.json<<EOF
      {
       "v": "2",
       "ps": "${user}@IanVPN",
       "add": "${BUG}.${domain}",
       "port": "${xtls}",
       "id": "${uuid}",
       "aid": "0",
       "scy": "auto",
       "net": "ws",
       "type": "none",
       "host": "${BUG}",
       "path": "/xrayvws",
       "tls": "tls",
       "sni": "${BUG}"
}
EOF
    vmess_base641=$( base64 -w 0 <<< $vmess_json1)
    vmesslink1="vmess://$(base64 -w 0 /etc/rare/xray/tls.json)"
	echo -e "${user}\t${uuid}\t${exp}" >> /etc/rare/xray/clients.txt
    cat /etc/rare/xray/conf/02_VLESS_TCP_inbounds.json | jq '.inbounds[0].settings.clients += [{"id": "'${uuid}'","add": "'${domain}'","flow": "xtls-rprx-direct","email": "'${email}'"}]' > /etc/rare/xray/conf/02_VLESS_TCP_inbounds_tmp.json
	mv -f /etc/rare/xray/conf/02_VLESS_TCP_inbounds_tmp.json /etc/rare/xray/conf/02_VLESS_TCP_inbounds.json
    cat /etc/rare/xray/conf/03_VLESS_WS_inbounds.json | jq '.inbounds[0].settings.clients += [{"id": "'${uuid}'","email": "'${email}'"}]' > /etc/rare/xray/conf/03_VLESS_WS_inbounds_tmp.json
	mv -f /etc/rare/xray/conf/03_VLESS_WS_inbounds_tmp.json /etc/rare/xray/conf/03_VLESS_WS_inbounds.json
    cat /etc/rare/xray/conf/04_trojan_TCP_inbounds.json | jq '.inbounds[0].settings.clients += [{"password": "'${uuid}'","email": "'${email}'"}]' > /etc/rare/xray/conf/04_trojan_TCP_inbounds_tmp.json
	mv -f /etc/rare/xray/conf/04_trojan_TCP_inbounds_tmp.json /etc/rare/xray/conf/04_trojan_TCP_inbounds.json
    cat /etc/rare/xray/conf/05_VMess_WS_inbounds.json | jq '.inbounds[0].settings.clients += [{"id": "'${uuid}'","alterId": 0,"add": "'${domain}'","email": "'${email}'"}]' > /etc/rare/xray/conf/05_VMess_WS_inbounds_tmp.json
	mv -f /etc/rare/xray/conf/05_VMess_WS_inbounds_tmp.json /etc/rare/xray/conf/05_VMess_WS_inbounds.json
    cat <<EOF >>"/etc/rare/config-user/${user}"
vless://$uuid@$domain:$xtls?flow=xtls-rprx-direct&encryption=none&security=xtls&sni=$BUG&type=tcp&headerType=none&host=$BUG#$user@IanVPN
vless://$uuid@$domain:$xtls?flow=xtls-rprx-splice&encryption=none&security=xtls&sni=$BUG&type=tcp&headerType=none&host=$BUG#$user@IanVPN
vless://$uuid@$domain:$xtls?encryption=none&security=xtls&sni=$BUG&type=ws&host=$BUG&path=/xrayws#$user@IanVPN
trojan://$uuid@$domain:$xtls?sni=$BUG#$user@IanVPN
${vmesslink1}
EOF
    
    systemctl restart xray.service
    echo -e "\033[32m[Info]\033[0m xray Start Successfully !"
    sleep 2
        clear
  echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\E[0;100;33m    • XRAY USER INFORMATION •      \E[0m"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"  
  echo -e ""   
  echo -e " Username      : $user"
  echo -e " Expired date  : $expired"
    echo -e " Jumlah Hari   : $duration Hari"
    echo -e " PORT          : $xtls"
    echo -e " UUID/PASSWORD : $uuid"
  echo -e ""
  echo -e " Pantang Larang IanVPN"
  echo -e " ‼️Aktiviti Berikut Adalah Dilarang"
    echo -e " (ID akan di ban tanpa notis & tiada refund)"
  echo -e " ❌Torrent (p2p, streaming p2p)"
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
  echo -e " Link VLESS SPLICE: vless://$uuid@$BUG.$domain:$xtls?flow=xtls-rprx-splice&encryption=none&security=xtls&sni=$BUG&type=tcp&headerType=none&host=$BUG#$user@IanVPN"
    echo -e ""
    echo -e " Link VLESS DIRECT: vless://$uuid@$BUG.$domain:$xtls?flow=xtls-rprx-direct&encryption=none&security=xtls&sni=$BUG&type=tcp&headerType=none&host=$BUG#$user@IanVPN"
    echo -e ""
  echo -e " Link VLESS WS: vless://$uuid@$BUG.$domain:$xtls?encryption=none&security=xtls&sni=$BUG&type=ws&host=$BUG&path=/xrayws#$user@IanVPN"
    echo -e ""
  echo -e " Link TROJAN: trojan://$uuid@$BUG.$domain:$xtls?sni=$BUG#$user@IanVPN"
    echo -e ""
    echo -e " Link VMESS TLS: ${vmesslink1}"
  echo -e ""
    echo -e " Link url OPENWRT/xrayN PC: https://${domain}/s/${uuid}"
  echo -e ""
  echo -e " Link url ASUS Clash: https://${domain}/s/${user}" 
  echo -e ""
  echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo ""
    read -n 1 -s -r -p "Press any key to back on menu"
    menu   
}
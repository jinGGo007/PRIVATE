#!/bin/bash
read -rp "Domain/Host: " -e host
echo "IP=$host" >> /var/lib/premium-script/ipvps.conf

#recert
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(wget -qO- icanhazip.com);
echo "Checking VPS"
clear
sleep 1
echo -e "============================================="
echo -e " ${green} RECERT V2RAY${NC}"
echo -e "============================================="
sleep 1
echo start
sleep 0.5
source /var/lib/premium-script/ipvps.conf
domain=$IP
systemctl stop v2ray
systemctl stop v2ray@none
/root/.acme.sh/acme.sh --issue -d $domain --standalone -k ec-256
~/.acme.sh/acme.sh --installcert -d $domain --fullchainpath /etc/v2ray/v2ray.crt --keypath /etc/v2ray/v2ray.key --ecc
systemctl start v2ray
systemctl start v2ray@none
echo Done
systemctl restart v2ray.service
systemctl restart v2ray@none.service
systemctl restart v2ray@vless.service
systemctl restart v2ray@vnone.service
systemctl restart trojan
sleep 0.5
clear 
echo start
sleep 0.5
source /var/lib/premium-script/ipvps.conf
domain=$(cat /etc/v2ray/domain)
systemctl stop xray
systemctl stop xray@none
systemctl stop xray@vless
systemctl stop xray@vnone
/root/.acme.sh/acme.sh --issue -d $domain --standalone -k ec-256
~/.acme.sh/acme.sh --installcert -d $domain --fullchainpath /etc/xray/xray.crt --keypath /etc/xray/xray.key --ecc
systemctl start xray
systemctl start xray@none
systemctl start xray@vless
systemctl start xray@vnone
echo Done
sleep 0.5
clear 
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu

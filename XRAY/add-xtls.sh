#!/bin/bash
uuid=$(cat /proc/sys/kernel/random/uuid)
source /var/lib/premium-script/ipvps.conf
if [[ "$IP" = "" ]]; then
domain=$(cat /etc/v2ray/domain)
else
domain=$IP
fi
vless1="$(cat ~/log-install.txt | grep -w "XRAY VLESS XTLS" | cut -d: -f2|sed 's/ //g')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
		read -rp "User: " -e user
		CLIENT_EXISTS=$(grep -w $user /etc/xray/xrayxtls.json | wc -l)

		if [[ ${CLIENT_EXISTS} == '1' ]]; then
			echo ""
			echo "A client with the specified name was already created, please choose another name."
			exit 1
		fi
	done
read -p "Expired (days): " masaaktif
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`

# // Input To Server
sed -i '/#xtls$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","flow": "xtls-rprx-direct","email": "'""$user""'"' /etc/xray/xrayxtls.json

vless_xtls="vless://${uuid}@${domain}:${vless1}?security=xtls&encryption=none&headerType=none&type=tcp&flow=xtls-rprx-direct&sni=bug.com&host=bug.com#$user"

# // Restarting Service
systemctl restart xtls

clear
echo -e ""
echo -e "==========-XRAYS/VLESS-=========="
echo -e "Remarks        : ${user}"
echo -e "Domain         : ${domain}"
echo -e "Port XTLS      : $vless1"
echo -e "id             : ${uuid}"
echo -e "path           : /xray"
echo -e "================================="
echo -e "Link XTLS      : ${vless_xtls}"
echo -e "================================="
echo -e "Expired On     : $exp"
echo -e ""
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu
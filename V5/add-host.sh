#!/bin/bash
clear
echo -e "MASUKKAN DOMAIN BARU ATAU TEKAN CTL C UTK EXIT"
echo -e ""
read -p "HOSTANME/DOMAIN: " host
rm -f /var/lib/premium-script/ipvps.conf
rm -f /etc/v2ray/domain
rm -f /etc/xray/domain
mkdir /etc/v2ray
mkdir /etc/xray
mkdir /var/lib/premium-script;
echo "IP=$host" >> /var/lib/premium-script/ipvps.conf
echo "$host" >> /etc/v2ray/domain
echo "$host" >> /etc/xray/domain
clear
#recert
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
sleep 1
echo -e "============================================="
echo -e " ${green} RECERT V2RAY${NC}"
echo -e "============================================="
sleep 1
echo start
sleep 0.5
source /var/lib/premium-script/ipvps.conf
domain=$IP
systemctl stop xr-vm-tls.service
systemctl stop xr-vm-ntls.service
systemctl stop xr-vl-tls.service
systemctl stop xr-vl-ntls.service
systemctl stop vmess-grpc.service
systemctl stop vless-grpc.service

/root/.acme.sh/acme.sh --issue -d $domain --standalone -k ec-256
~/.acme.sh/acme.sh --installcert -d $domain --fullchainpath /etc/v2ray/v2ray.crt --keypath /etc/v2ray/v2ray.key --ecc
systemctl start xr-vm-tls.service
systemctl start xr-vm-ntls.service
systemctl start xr-vl-tls.service
systemctl start xr-vl-ntls.service
systemctl start vmess-grpc.service
systemctl start vless-grpc.service
echo Done
sleep 0.5
clear
echo -e "============================================="
echo -e " ${green} PERTUKARAN DOMAIN SELESAI${NC}"
echo -e "============================================="
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu
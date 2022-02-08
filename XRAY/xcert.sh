#!/bin/bash
echo start
sleep 0.5
source /var/lib/premium-script/ipvps.conf
domain=$IP
systemctl stop xr-vm-tls.service
systemctl stop xr-vm-ntls.service
systemctl stop xr-vl-tls.service
systemctl stop xr-vl-ntls.service
systemctl stop xtls.service
systemctl stop x-tr.service
systemctl stop x-tr.service
systemctl stop vmess-grpc.service
systemctl stop vless-grpc.service
/root/.acme.sh/acme.sh --issue -d $domain --standalone -k ec-256
~/.acme.sh/acme.sh --installcert -d $domain --fullchainpath /etc/xray/xray.crt --keypath /etc/xray/xray.key --ecc
systemctl start xr-vm-tls.service
systemctl start xr-vm-ntls.service
systemctl start xr-vl-tls.service
systemctl start xr-vl-ntls.service
systemctl start xtls.service
systemctl start x-tr.service
systemctl start x-tr.service
systemctl start vmess-grpc.service
systemctl start vless-grpc.service
echo Done
sleep 0.5
clear 
neofetch
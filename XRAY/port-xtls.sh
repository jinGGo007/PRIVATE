#!/bin/bash
MYIP=$(wget -qO- icanhazip.com);
echo "Checking Vps"
clear

xtls="$(cat ~/log-install.txt | grep -w "XRAY VLESS XTLS" | cut -d: -f2|sed 's/ //g')"
echo -e "======================================"

echo -e "Change Port $xtls"

echo -e "======================================"
read -p "New Port Xray Vless Xtls : " xtls2
if [ -z $xtls2 ]; then
echo "Please Input Port"
exit 0
fi
cek=$(netstat -nutlp | grep -w $xtls2)
if [[ -z $cek ]]; then
sed -i "s/$xtls/$xtls2/g" /etc/xray/xrayxtls.json
sed -i "s/   - XRAY VLESS XTLS         : $xtls/   - XRAY VLESS XTLS     : $xtls2/g" /root/log-install.txt
iptables -D INPUT -m state --state NEW -m tcp -p tcp --dport $xtls -j ACCEPT
iptables -D INPUT -m state --state NEW -m udp -p udp --dport $xtls -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport $xtls2 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport $xtls2 -j ACCEPT
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save > /dev/null
netfilter-persistent reload > /dev/null
systemctl restart xray.service > /dev/null
echo -e "\e[032;1mPort $xtls2 modified successfully\e[0m"
else
echo "Port $xtls2 is used"
fi
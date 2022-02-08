#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(wget -qO- ifconfig.me/ip);
echo "Checking VPS"
clear
tr="$(cat ~/log-install.txt | grep -w "TROGAN GO" | cut -d: -f2|sed 's/ //g')"
echo -e "Name : Change Port Trojan GO"
echo -e "============================" 
echo -e "Change Port $tr"
read -p "New Port Trojan-go: " tr2
if [ -z $tr2 ]; then
echo "Please Input Port"
exit 0
fi
cek=$(netstat -nutlp | grep -w $tls1)
if [[ -z $cek ]]; then
sed -i "s/$tls/$tls1/g" /etc/xray/trojan.json
sed -i "s/   - TROGAN GO          : $tls/   - TROGAN GO          : $tls1/g" /root/log-install.txt
iptables -D INPUT -m state --state NEW -m tcp -p tcp --dport $tls -j ACCEPT
iptables -D INPUT -m state --state NEW -m udp -p udp --dport $tls -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport $tls1 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport $tls1 -j ACCEPT
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save > /dev/null
netfilter-persistent reload > /dev/null
systemctl stop x-tr.service > /dev/null
systemctl enable x-tr.service > /dev/null
systemctl start x-tr.service > /dev/null
systemctl restart x-tr.service > /dev/null
echo -e "\e[032;1mPort $tr2 modified successfully\e[0m"
else
echo "Port $tr2 is used"
fi
#!/bin/bash
MYIP=$(wget -qO- icanhazip.com);
echo "Checking Vps"
clear
tr="$(cat ~/log-install.txt | grep -i "TROGAN GO" | cut -d: -f2|sed 's/ //g')"
echo -e "Name : Change Port Trojan GO"
echo -e "============================" | lolcat
echo -e "Change Port $tr"
read -p "New Port Trojan-go: " tr2
if [ -z $tr2 ]; then
echo "Please Input Port"
exit 0
fi
cek=$(netstat -nutlp | grep -w $tr2)
if [[ -z $cek ]]; then
sed -i "s/$tr/$tr2/g" /etc/xray/trojan.json
sed -i "s/   - TROGAN GO                  : $tr/   - TROGAN GO                  : $tr2/g" /root/log-install.txt
iptables -D INPUT -m state --state NEW -m tcp -p tcp --dport $tr -j ACCEPT
iptables -D INPUT -m state --state NEW -m udp -p udp --dport $tr -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport $tr2 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport $tr2 -j ACCEPT
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save > /dev/null
netfilter-persistent reload > /dev/null
systemctl restart x-tr.service > /dev/null
echo -e "\e[032;1mPort $tr2 modified successfully\e[0m"
else
echo "Port $tr2 is used"
fi

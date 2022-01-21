#!/bin/bash
if [ "${EUID}" -ne 0 ]; then
		echo "You need to run this script as root"
		exit 1
fi
if [ "$(systemd-detect-virt)" == "openvz" ]; then
		echo "OpenVZ is not supported"
		exit 1
fi
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'

# Script Access 
MYIP=$(wget -qO- icanhazip.com);
sleep 2

# Subdomain Settings
echo -e "============================================="
echo -e "${green}      Input Domain${NC} "
echo -e "============================================="
sleep 2
mkdir /root;
mkdir /etc/v2ray
mkdir /var/lib/premium-script;
clear
echo -e ""
echo -e "${green}MASUKKAN DOMAIN ANDA YANG TELAH DI POINT KE IP ANDA${NC}"
read -rp "    Enter your Domain/Host: " -e host
ip=$(wget -qO- ipv4.icanhazip.com)
host_ip=$(ping "${host}" -c 1 | sed '1{s/[^(]*(//;s/).*//;q}')
if [[ ${host_ip} == "${ip}" ]]; then
	echo -e "${green}HOST/DOMAIN MATCHED..INSTALLATION WILL CONTINUE${NC}"
	echo "IP=$host" >> /var/lib/premium-script/ipvps.conf
        echo "$host" > /etc/v2ray/domain
        echo "$host" > /root/domain
	sleep 2
	clear
else
	echo -e "${green}HOST/DOMAIN NOT MATCHED..INSTALLATION WILL TERMINATED${NC}"
	echo -e ""
        rm -f setup.sh
        exit 1
fi

# Update & Upgrade
apt update
apt upgrade -y

# Disable IPv6
sysctl -w net.ipv6.conf.all.disable_ipv6=1
sysctl -w net.ipv6.conf.default.disable_ipv6=1
sysctl -w net.ipv6.conf.lo.disable_ipv6=1
echo -e "net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1" >> /etc/sysctl.conf

# Install curl
apt install -y bzip2 gzip coreutils screen curl
sleep 2

#install ssh ovpn
echo -e "============================================="
echo -e " ${green} Installing SSH & OPENVPN & WS ${NC}"
echo -e "============================================="
sleep 2
wget https://raw.githubusercontent.com/jinGGo007/PRIVATE/SSHOVPN/main/ssh-vpn.sh && chmod +x ssh-vpn.sh && screen -S ssh-vpn ./ssh-vpn.sh

#install ssr
echo -e "============================================="
echo -e " ${green}        Installing ssr${NC} "
echo -e "============================================="
sleep 2
wget https://raw.githubusercontent.com/jinGGo007/PRIVATE/SSR/main/ssr.sh && chmod +x ssr.sh && screen -S ssr ./ssr.sh

#install ss
echo -e "============================================="
echo -e " ${green}        Installing shadowsocksobfs${NC} "
echo -e "============================================="
sleep 2
wget https://raw.githubusercontent.com/jinGGo007/PRIVATE/SS/main/sodosok.sh && chmod +x sodosok.sh && screen -S ss ./sodosok.sh

#install wg
echo -e "============================================="
echo -e " ${green}        Installing WIREGUARD${NC} "
echo -e "============================================="
sleep 2
wget https://raw.githubusercontent.com/jinGGo007/PRIVATE/WG/main/wg.sh && chmod +x wg.sh && screen -S wg ./wg.sh

#install v2ray
echo -e "============================================="
echo -e " ${green}        Installing V2RAY${NC} "
echo -e "============================================="
sleep 2
wget https://raw.githubusercontent.com/jinGGo007/PRIVATE/V2RAY/main/ins-vt.sh && chmod +x ins-vt.sh && screen -S v2ray ./ins-vt.sh

#install ohp
echo -e "============================================="
echo -e " ${green}        Installing OHP${NC} "
echo -e "============================================="
sleep 2
wget https://raw.githubusercontent.com/jinGGo007/PRIVATE/OHP/main/ohpserver.sh && chmod +x ohpserver.sh && ./ohpserver.sh

rm -f /root/ssh-vpn.sh
rm -f /root/wg.sh
rm -f /root/ss.sh
rm -f /root/ssr.sh
rm -f /root/ins-vt.sh
rm -f /root/ohpserver.sh

apt install -y dos2unix && dos2unix running
cat <<EOF> /etc/systemd/system/autosett.service
[Unit]
Description=autosetting
Documentation=JINGGO007
[Service]
Type=oneshot
ExecStart=/bin/bash /etc/set.sh
RemainAfterExit=yes
[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl enable autosett
wget -O /etc/set.sh "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/set.sh"
chmod +x /etc/set.sh
history -c
echo "1.2" > /home/ver
clear
# download script menu
echo -e "============================================="
echo -e " ${green} Installing SSH & OPENVPN & WS ${NC}"
echo -e "============================================="
sleep 2
cd /usr/bin
wget -O menu "https://raw.githubusercontent.com/jinGGo007/PRIVATE/MENU/main/menu.sh"
wget -O add-host "https://raw.githubusercontent.com/jinGGo007/PRIVATE/MENU/main/add-host.sh"
wget -O about "https://raw.githubusercontent.com/jinGGo007/PRIVATE/MENU/main/about.sh"
wget -O usernew "https://raw.githubusercontent.com/jinGGo007/PRIVATE/MENU/main/usernew.sh"
wget -O trial "https://raw.githubusercontent.com/jinGGo007/PRIVATE/MENU/main/trial.sh"
wget -O hapus "https://raw.githubusercontent.com/jinGGo007/PRIVATE/MENU/main/hapus.sh"
wget -O member "https://raw.githubusercontent.com/jinGGo007/PRIVATE/MENU/main/member.sh"
wget -O delete "https://raw.githubusercontent.com/jinGGo007/PRIVATE/MENU/main/delete.sh"
wget -O cek "https://raw.githubusercontent.com/jinGGo007/PRIVATE/MENU/main/cek.sh"
wget -O restart "https://raw.githubusercontent.com/jinGGo007/PRIVATE/MENU/main/restart.sh"
wget -O speedtest "https://raw.githubusercontent.com/jinGGo007/PRIVATE/MENU/main/speedtest_cli.py"
wget -O info "https://raw.githubusercontent.com/jinGGo007/PRIVATE/MENU/main/info.sh"
wget -O ram "https://raw.githubusercontent.com/jinGGo007/PRIVATE/MENU/main/ram.sh"
wget -O renew "https://raw.githubusercontent.com/jinGGo007/PRIVATE/MENU/main/renew.sh"
wget -O autokill "https://raw.githubusercontent.com/jinGGo007/PRIVATE/MENU/MENU/main/autokill.sh"
wget -O ceklim "https://raw.githubusercontent.com/jinGGo007/PRIVATE/MENU/main/ceklim.sh"
wget -O tendang "https://raw.githubusercontent.com/jinGGo007/PRIVATE/MENU/main/tendang.sh"
wget -O change "https://raw.githubusercontent.com/jinGGo007/PRIVATE/MENU/main/change.sh"
wget -O port-ovpn "https://raw.githubusercontent.com/jinGGo007/PRIVATE/MENU/main/port-ovpn.sh"
wget -O port-ssl "https://raw.githubusercontent.com/jinGGo007/PRIVATE/MENU/main/port-ssl.sh"
wget -O port-wg "https://raw.githubusercontent.com/jinGGo007/PRIVATE/MENU/main/port-wg.sh"
wget -O port-tr "https://raw.githubusercontent.com/jinGGo007/PRIVATE/MENU/main/port-tr.sh"
wget -O port-squid "https://raw.githubusercontent.com/jinGGo007/PRIVATE/MENU/main/port-squid.sh"
wget -O port-ws "https://raw.githubusercontent.com/jinGGo007/PRIVATE/MENU/main/port-ws.sh"
wget -O port-vless "https://raw.githubusercontent.com/jinGGo007/PRIVATE/MENU/main/port-vless.sh"
wget -O wbmn "https://raw.githubusercontent.com/jinGGo007/PRIVATE/MENU/main/webmin.sh"
wget -O xp "https://raw.githubusercontent.com/jinGGo007/PRIVATE/MENU/main/xp.sh"
wget -O checksystem "https://raw.githubusercontent.com/jinGGo007/PRIVATE/MENU/main/checksystem.sh"
chmod +x menu
chmod +x add-host
chmod +x usernew
chmod +x trial
chmod +x hapus
chmod +x member
chmod +x delete
chmod +x cek
chmod +x restart
chmod +x speedtest
chmod +x info
chmod +x about
chmod +x autokill
chmod +x tendang
chmod +x ceklim
chmod +x ram
chmod +x renew
chmod +x clear-log
chmod +x change
chmod +x port-ovpn
chmod +x port-ssl
chmod +x port-wg
chmod +x port-tr
chmod +x port-squid
chmod +x port-ws
chmod +x port-vless
chmod +x wbmn
chmod +x xp
chmod +x checksystem
echo "0 5 * * * root clear-log && reboot" >> /etc/crontab
echo "0 0 * * * root xp" >> /etc/crontab
sleep 2
clear
echo " "
echo "Installation Completed!!"
echo " "
echo "=================================-Autoscript Premium-===========================" | tee -a log-install.txt
echo "" | tee -a log-install.txt
echo "--------------------------------------------------------------------------------" | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "   >>> Service & Port"  | tee -a log-install.txt
echo "   - OpenSSH                 : 22"  | tee -a log-install.txt
echo "   - OpenVPN                 : TCP 1194, UDP 2200, SSL 442"  | tee -a log-install.txt
echo "   - Stunnel4                : 443, 777"  | tee -a log-install.txt
echo "   - Dropbear                : 109, 143"  | tee -a log-install.txt
echo "   - Squid Proxy             : 3128, 8080 (limit to IP Server)"  | tee -a log-install.txt
echo "   - Badvpn                  : 7100, 7200, 7300"  | tee -a log-install.txt
echo "   - Nginx                   : 81"  | tee -a log-install.txt
echo "   - Wireguard               : 7070"  | tee -a log-install.txt
echo "   - SSH WS/OVPN WS          : 2082, 2095"  | tee -a log-install.txt
echo "   - DROPBEAR OHP            : 8090"  | tee -a log-install.txt
echo "   - OPENVPN OHP             : 8089"  | tee -a log-install.txt
echo "   - Shadowsocks-R           : 1443-1543"  | tee -a log-install.txt
echo "   - SS-OBFS TLS             : 2443-2543"  | tee -a log-install.txt
echo "   - SS-OBFS HTTP            : 3443-3543"  | tee -a log-install.txt
echo "   - V2RAY Vmess TLS         : 8443"  | tee -a log-install.txt
echo "   - V2RAY Vmess None TLS    : 80"  | tee -a log-install.txt
echo "   - V2RAY Vless TLS         : 2083"  | tee -a log-install.txt
echo "   - V2RAY Vless None TLS    : 8880"  | tee -a log-install.txt
echo "   - Trojan                  : 2087"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "   >>> Server Information & Other Features"  | tee -a log-install.txt
echo "   - Timezone                : Asia/MALAYSIA (GMT +8)"  | tee -a log-install.txt
echo "   - Fail2Ban                : [ON]"  | tee -a log-install.txt
echo "   - Dflate                  : [ON]"  | tee -a log-install.txt
echo "   - IPtables                : [ON]"  | tee -a log-install.txt
echo "   - Auto-Reboot             : [ON]"  | tee -a log-install.txt
echo "   - IPv6                    : [OFF]"  | tee -a log-install.txt
echo "   - Autoreboot On 05.00 GMT +8" | tee -a log-install.txt
echo "   - Autobackup Data" | tee -a log-install.txt
echo "   - Restore Data" | tee -a log-install.txt
echo "   - Auto Delete Expired Account" | tee -a log-install.txt
echo "   - Full Orders For Various Services" | tee -a log-install.txt
echo "   - White Label" | tee -a log-install.txt
echo "   - Installation Log --> /root/log-install.txt"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "   - Dev/Main                : Horas"  | tee -a log-install.txt
echo "   - Modded by               : JINGGO007"  | tee -a log-install.txt
echo "   - Telegram                : t.me/jinggo007"  | tee -a log-install.txt
echo "   - Instagram               : None"  | tee -a log-install.txt
echo "   - Whatsapp                : 999"  | tee -a log-install.txt
echo "   - Facebook                : johnlabu" | tee -a log-install.txt
echo "------------------Script Modded By JINGGO007-----------------" | tee -a log-install.txt
echo ""
sleep 1
rm -f setup.sh
read -n 1 -r -s -p $'Press any key to reboot...\n';reboot

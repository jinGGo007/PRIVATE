#!/bin/bash

clear
if [ "${EUID}" -ne 0 ]; then
		echo "You need to run this script as root"
		exit 1
fi
if [ "$(systemd-detect-virt)" == "openvz" ]; then
		echo "OpenVZ is not supported"
		exit 1
fi
clear

MYIP=$(wget -qO- ifconfig.co);
echo "Checking VPS"
clear
echo -e " "

echo -e " "
ISP=$(curl -s ipinfo.io/org | cut -d " " -f 2-10 )
CITY=$(curl -s ipinfo.io/city )
WKT=$(curl -s ipinfo.io/timezone )
IPVPS=$(curl -s ipinfo.io/ip )
DOMAIN=$(cat /etc/v2ray/domain)
	cname=$( awk -F: '/model name/ {name=$2} END {print name}' /proc/cpuinfo )
	cores=$( awk -F: '/model name/ {core++} END {print core}' /proc/cpuinfo )
	freq=$( awk -F: ' /cpu MHz/ {freq=$2} END {print freq}' /proc/cpuinfo )
	tram=$( free -m | awk 'NR==2 {print $2}' )
	swap=$( free -m | awk 'NR==4 {print $2}' )
	up=$(uptime|awk '{ $1=$2=$(NF-6)=$(NF-5)=$(NF-4)=$(NF-3)=$(NF-2)=$(NF-1)=$NF=""; print }')


echo -e  " $bl \e[032;1mCPU Model:\e[0m$bd $cname  "
echo -e  " $bl \e[032;1mNumber Of Cores:\e[0m$bd $cores"
echo -e  " $bl \e[032;1mCPU Frequency:\e[0m$bd $freq MHz"
echo -e  " $bl \e[032;1mTotal Amount Of RAM:\e[0m$bd $tram MB"
echo -e  " $op \e[032;1mSystem Uptime:\e[0m$bd $up"
echo -e  " $op \e[032;1mIsp Name:\e[0m$bd $ISP"
echo -e  " $op \e[032;1mIp Vps:\e[0m$bd $IPVPS"
echo -e  " $op \e[032;1mCity:\e[0m$bd $CITY"
echo -e  " $op \e[032;1mTime:\e[0m$bd $WKT "
echo -e  " $op \e[032;1mDOMAIN:\e[0m $DOMAIN"
echo -e  " AUTOSCRIPT LITE VERSION MODDED BY JINGGO007" | lolcat
echo -e  " "
echo -e  " ═════════════════════════════════════════════════════════════════ "
echo -e  " MAIN MENU "                                       
echo -e  " ═════════════════════════════════════════════════════════════════ "
echo -e  " "
echo -e  " [ 1 ] SSH & OpenVPN" 
echo -e  " [ 2 ] Panel Wireguard" 
echo -e  " [ 3 ] Panel SSR & SS" 
echo -e  " [ 4 ] Panel VMESS" 
echo -e  " [ 5 ] Panel VLESS" 
echo -e  " [ 6 ] Panel Trojan" 
echo -e  "  "
echo -e  " ═════════════════════════════════════════════════════════════════ "
echo -e  " SYSTEM MENU "       
echo -e  " ═════════════════════════════════════════════════════════════════ "                            
echo -e  "  "
echo -e  " [  7 ] Add/Change Subdomain Host For VPS"
echo -e  " [  8 ] Change Port Of Some Service"
echo -e  " [  9 ] Webmin Menu"
echo -e  " [ 10 ] Check Usage of VPS Ram"
echo -e  " [ 11 ] Reboot VPS"
echo -e  " [ 12 ] Speedtest VPS"
echo -e  " [ 13 ] Displaying System Information"
echo -e  " [ 14 ] Info Script"
echo -e  " [ 15 ] Check System Error"
echo -e  "  "
echo -e  "  ═════════════════════════════════════════════════════════════════" 
echo -e  "  [ 0 ] EXIT MENU "
echo -e  "  ═════════════════════════════════════════════════════════════════"
echo -e  ""
read -p  "     Please select an option :  " menu
echo -e   ""
 case $menu in
   1)
   mssh
   ;;
   2)
   mwg
   ;;
   3)
   mss-ssr
   ;;
   4)
   mvmess
   ;;
   5)
   mvless
   ;;
   6)
   mtrojan
   ;;
   7)
   add-host
   ;;
   8)
   change
   ;;
   9)
   wbmn
   ;;
   10)
   ram
   ;;
   11)
   reboot
   ;;
   12)
   speedtest
   ;;
   13)
   info
   ;;
   14)
   about
   ;;
   15)
   checksystem
   ;;
   0)
   exit
   ;;
   *)
   echo -e "ERROR!! Please Enter an Correct Number"
   ;;
  esac

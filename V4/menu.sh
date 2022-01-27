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

MYIP=$(wget -qO- icanhazip.com);
echo "Checking VPS"
clear

echo -e " "
ISP=$(curl -s ipinfo.io/org | cut -d " " -f 2-10 )
CITY=$(curl -s ipinfo.io/city )
WKT=$(curl -s ipinfo.io/timezone )
IPVPS=$(curl -s ipinfo.io/ip )
DOMAIN=$(cat /etc/v2ray/domain)


echo -e  "           AUTOSCRIPT LITE VERSION MODDED BY JINGGO007" | lolcat
echo -e  " "
echo -e  " $op \e[032;1mIsp Name    :\e[0m$bd $ISP"
echo -e  " $op \e[032;1mIp Vps      :\e[0m$bd $IPVPS"
echo -e  " $op \e[032;1mCity        :\e[0m$bd $CITY"
echo -e  " $op \e[032;1mTime        :\e[0m$bd $WKT "
echo -e  " $op \e[032;1mDOMAIN      :\e[0m $DOMAIN"
echo -e  " "
echo -e  " ═════════════════════════════════════════════════════════════════ "
echo -e  " MAIN MENU "                                       
echo -e  " ═════════════════════════════════════════════════════════════════ "
echo -e  " "
echo -e  " [ 1 ] SSH & OpenVPN"  
echo -e  " [ 2 ] Panel VLESS" 
echo -e  "  "
echo -e  " ═════════════════════════════════════════════════════════════════ "
echo -e  " SYSTEM MENU "       
echo -e  " ═════════════════════════════════════════════════════════════════ "                            
echo -e  "  "
echo -e  " [  3 ] Add/Change Subdomain Host For VPS"
echo -e  " [  4 ] Change Port Of Some Service"
echo -e  " [  5 ] Webmin Menu"
echo -e  " [  6 ] Check Usage of VPS Ram"
echo -e  " [  7 ] Reboot VPS"
echo -e  " [  8 ] Speedtest VPS"
echo -e  " [  9 ] Displaying System Information"
echo -e  " [ 10 ] Info Script"
echo -e  " [ 11 ] Check System Error"
echo -e  "  "
echo -e  " ═════════════════════════════════════════════════════════════════" 
echo -e  " [  0 ] EXIT MENU  "
echo -e  " ═════════════════════════════════════════════════════════════════"
echo -e  "  "
echo -e "\e[1;31m"
read -p  "     Please select an option :  " menu
echo -e "\e[0m"
 case $menu in
   1)
   mssh
   ;;
   2)
   mvless
   ;;
   3)
   add-host
   ;;
   4)
   change
   ;;
   5)
   wbmn
   ;;
   6)
   ram
   ;;
   7)
   reboot
   ;;
   8)
   speedtest
   ;;
   9)
   info
   ;;
   10)
   about
   ;;
   11)
   checksystem
   ;;
   0)
   exit
   ;;
   *)
   echo -e "ERROR!! Please Enter an Correct Number"
   sleep 1
   clear
   menu
   ;;
   esac

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


echo -e  "          AUTOSCRIPT LITE VERSION MODDED BY JINGGO007" | lolcat

echo -e  " "
echo -e  " ═════════════════════════════════════════════════════════════════ "
echo -e  " MAIN MENU "                                       
echo -e  " ═════════════════════════════════════════════════════════════════ "
echo -e  " "
echo -e  " [ 1 ] SSH & OpenVPN" 
echo -e  " [ 2 ] Panel Wireguard" 
echo -e  " [ 3 ] Panel SSR" 
echo -e  " [ 4 ] Panel SS"
echo -e  " [ 5 ] Panel VMESS" 
echo -e  " [ 6 ] Panel VLESS" 
echo -e  " [ 7 ] Panel XRAY"
echo -e  " [ 8 ] Panel Trojan" 
echo -e  "  "
echo -e  " ═════════════════════════════════════════════════════════════════ "
echo -e  " SYSTEM MENU "       
echo -e  " ═════════════════════════════════════════════════════════════════ "                            
echo -e  "  "
echo -e  " [  9 ] Add/Change Subdomain Host For VPS"
echo -e  " [ 10 ] Change Port Of Some Service"
echo -e  " [ 11 ] Webmin Menu"
echo -e  " [ 12 ] Check Usage of VPS Ram"
echo -e  " [ 13 ] Reboot VPS"
echo -e  " [ 14 ] Speedtest VPS"
echo -e  " [ 15 ] Displaying System Information"
echo -e  " [ 16 ] Info Script"
echo -e  " [ 17 ] Check System Error"
echo -e  "  "
echo -e  " ═════════════════════════════════════════════════════════════════" 
echo -e  " [  0 ] EXIT MENU "
echo -e  " ═════════════════════════════════════════════════════════════════"
echo -e "\e[1;31m"
read -p  "     Please select an option :  " menu
echo -e "\e[0m"
 case $menu in
   1)
   mssh
   ;;
   2)
   mwg
   ;;
   3)
   mssr
   ;;
   4)
   mss
   ;;
   5)
   mvmess
   ;;
   6)
   mvless
   ;;
   7)
   mxray
   ;;
   8)
   mtrojan
   ;;
   9)
   add-host
   ;;
   10)
   change
   ;;
   11)
   wbmn
   ;;
   12)
   ram
   ;;
   13)
   reboot
   ;;
   14)
   speedtest
   ;;
   15)
   info
   ;;
   16)
   about
   ;;
   17)
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
   exit
   ;;
   esac

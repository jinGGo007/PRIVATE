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
echo -e  " [ 2 ] Panel VMESS" 
echo -e  " [ 3 ] Panel VLESS" 
echo -e  " [ 4 ] Panel Trojan" 
echo -e  "  "
echo -e  " ═════════════════════════════════════════════════════════════════ "
echo -e  " SYSTEM MENU "       
echo -e  " ═════════════════════════════════════════════════════════════════ "                            
echo -e  "  "
echo -e  " [  5 ] Add/Change Subdomain Host For VPS"
echo -e  " [  6 ] Change Port Of Some Service"
echo -e  " [  7 ] Webmin Menu"
echo -e  " [  8 ] Check Usage of VPS Ram"
echo -e  " [  9 ] Reboot VPS"
echo -e  " [ 10 ] Speedtest VPS"
echo -e  " [ 11 ] Displaying System Information"
echo -e  " [ 12 ] Info Script"
echo -e  " [ 13 ] Check System Error"
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
   mvmess
   ;;
   3)
   mvless
   ;;
   4)
   mtrojan
   ;;
   5)
   add-host
   ;;
   6)
   change
   ;;
   7)
   wbmn
   ;;
   8)
   ram
   ;;
   9)
   reboot
   ;;
   10)
   speedtest
   ;;
   11)
   info
   ;;
   12)
   about
   ;;
   13)
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
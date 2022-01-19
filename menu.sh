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

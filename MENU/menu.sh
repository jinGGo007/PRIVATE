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
echo -e  " [ 7 ] Panel Trojan" 
echo -e  "  "
echo -e  " ═════════════════════════════════════════════════════════════════ "
echo -e  " SYSTEM MENU "       
echo -e  " ═════════════════════════════════════════════════════════════════ "                            
echo -e  "  "
echo -e  " [  8 ] Add/Change Subdomain Host For VPS"
echo -e  " [  9 ] Change Port Of Some Service"
echo -e  " [ 10 ] Webmin Menu"
echo -e  " [ 11 ] Check Usage of VPS Ram"
echo -e  " [ 12 ] Reboot VPS"
echo -e  " [ 13 ] Speedtest VPS"
echo -e  " [ 14 ] Displaying System Information"
echo -e  " [ 15 ] Info Script"
echo -e  " [ 16 ] Check System Error"
echo -e  "  "
echo -e  " ═════════════════════════════════════════════════════════════════" 
echo -e  "  [ 0 ] EXIT MENU "
echo -e  " ═════════════════════════════════════════════════════════════════"
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
   mtrojan
   ;;
   8)
   add-host
   ;;
   9)
   change
   ;;
   10)
   wbmn
   ;;
   11)
   ram
   ;;
   12)
   reboot
   ;;
   13)
   speedtest
   ;;
   14)
   info
   ;;
   15)
   about
   ;;
   16)
   checksystem
   ;;
   0)
   exit
   ;;
   *)
   echo -e "ERROR!! Please Enter an Correct Number"
   ;;
  esac

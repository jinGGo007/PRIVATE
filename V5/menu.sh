#!/bin/bash
clear
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'

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
echo -e  " ${green}MAIN MENU${NC} "                                       
echo -e  " ═════════════════════════════════════════════════════════════════ "
echo -e  " "
echo -e  " [  1 ] SSH & OpenVPN" 
echo -e  " [  2 ] Panel VMESS" 
echo -e  " [  3 ] Panel VLESS" 
echo -e  " [  4 ] Panel Trojan" 
echo -e  " [  5 ] Panel XRAY" 
echo -e  "  "
echo -e  " ═════════════════════════════════════════════════════════════════ "
echo -e  " ${green}SYSTEM MENU${NC} "       
echo -e  " ═════════════════════════════════════════════════════════════════ "                            
echo -e  "  "
echo -e  " [  6 ] Add/Change Subdomain Host For VPS"
echo -e  " [  7 ] Change Port Of Some Service"
echo -e  " [  8 ] Webmin Menu"
echo -e  " [  9 ] Check Usage of VPS Ram"
echo -e  " [ 10 ] Reboot VPS"
echo -e  " [ 11 ] Speedtest VPS"
echo -e  " [ 12 ] Displaying System Information"
echo -e  " [ 13 ] Info Script"
echo -e  " [ 14 ] Check System Error"
echo -e  "  "
echo -e  " ═════════════════════════════════════════════════════════════════" 
echo -e  " ${green}[  0 ] EXIT MENU${NC}  "
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
   mxray
   ;;
   6)
   add-host
   ;;
   7)
   change
   ;;
   8)
   wbmn
   ;;
   9)
   ram
   ;;
   10)
   reboot
   ;;
   11)
   speedtest
   ;;
   12)
   info
   ;;
   13)
   about
   ;;
   14)
   checksystem
   ;;
   0)
   sleep 0.5
   clear
   exit
   clear
   ;;
   *)
   echo -e "ERROR!! Please Enter an Correct Number"
   sleep 1
   clear
   menu
   ;;
   esac

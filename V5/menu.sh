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
echo -e  "                           VERSION 5" | lolcat
echo -e  " "
echo -e  " ${green}ISP NAME           :${NC} $ISP"
echo -e  " ${green}IP VPS NUMBER      :${NC} $IPVPS"
echo -e  " ${green}LOCATION           :${NC} $CITY"
echo -e  " ${green}TIME               :${NC} $WKT "
echo -e  " ${green}DOMAIN             :${NC} $DOMAIN"
echo -e  " "
echo -e  " ═════════════════════════════════════════════════════════════════ "
echo -e  " ${green}MAIN MENU${NC} "                                       
echo -e  " ═════════════════════════════════════════════════════════════════ "
echo -e  " "
echo -e  " [  1 ] SSH & OPENVPN" 
echo -e  " [  2 ] V2RAY VMESS" 
echo -e  " [  3 ] V2RAY VLESS" 
echo -e  " [  4 ] TROJAN GFW" 
echo -e  " [  5 ] XRAY VLESS DIRECT"  
echo -e  "  "
echo -e  " ═════════════════════════════════════════════════════════════════ "
echo -e  " ${green}SYSTEM MENU${NC} "       
echo -e  " ═════════════════════════════════════════════════════════════════ "                            
echo -e  "  "
echo -e  " [  6 ] ADD/CHANGE DOMAIN VPS"
echo -e  " [  7 ] CHANGE PORT SERVICE"
echo -e  " [  8 ] WEBMIN MENU"
echo -e  " [  9 ] CHECK RAM USAGE"
echo -e  " [ 10 ] REBOOT VPS"
echo -e  " [ 11 ] SPEEDTEST VPS"
echo -e  " [ 12 ] DISPLAY SYSTEM INFORMATION"
echo -e  " [ 13 ] INFO SCRIPT"
echo -e  " [ 14 ] CHECK SERVICE ERROR"
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

#!/bin/bash
clear
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'

echo -e " "
IPVPS=$(curl -s icanhazip.com)
DOMAIN=$(cat /etc/v2ray/domain)


echo -e  "           AUTOSCRIPT LITE VERSION MODDED BY JINGGO007" | lolcat
echo -e  "                           VERSION 5" | lolcat
echo -e  " "
echo -e  " ${green}IP VPS NUMBER      :${NC} $IPVPS"
echo -e  " ${green}DOMAIN             :${NC} $DOMAIN"
echo -e  " "
echo -e  " ═════════════════════════════════════════════════════════════════ "
echo -e  " ${green}MAIN MENU${NC} "                                       
echo -e  " ═════════════════════════════════════════════════════════════════ "
echo -e  " "
echo -e  " [  1 ] SSH & OPENVPN" 
echo -e  " [  2 ] V2RAY VMESS" 
echo -e  " [  3 ] V2RAY VLESS" 
echo -e  " [  4 ] XRAY VLESS XTLS" 
echo -e  " [  5 ] XRAY VLESS GRPC" 
echo -e  " [  6 ] TROJAN GFW" 
echo -e  "  "
echo -e  " ═════════════════════════════════════════════════════════════════ "
echo -e  " ${green}SYSTEM MENU${NC} "       
echo -e  " ═════════════════════════════════════════════════════════════════ "                            
echo -e  "  "
echo -e  " [  7 ] ADD/CHANGE DOMAIN VPS"
echo -e  " [  8 ] CHANGE PORT SERVICE"
echo -e  " [  9 ] RENEW V2RAY CERTIFICATION"
echo -e  " [ 10 ] WEBMIN MENU"
echo -e  " [ 11 ] CHECK RAM USAGE"
echo -e  " [ 12 ] REBOOT VPS"
echo -e  " [ 13 ] SPEEDTEST VPS"
echo -e  " [ 14 ] DISPLAY SYSTEM INFORMATION"
echo -e  " [ 15 ] INFO SCRIPT"
echo -e  " [ 16 ] CHECK SERVICE ERROR"
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
   mxray
   ;;
   5)
   mgrpc
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
   recert-v2ray
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

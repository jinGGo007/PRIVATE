#!/bin/bash

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
echo -e  " [  1 ] SSH & OpenVPN" 
echo -e  " [  2 ] Panel V2ray" 
echo -e  " [  3 ] Panel Xray" 
echo -e  "  "
echo -e  " ═════════════════════════════════════════════════════════════════ "
echo -e  " SYSTEM MENU "       
echo -e  " ═════════════════════════════════════════════════════════════════ "                            
echo -e  "  "
echo -e  " [  4 ] Add/Change Subdomain Host For VPS"
echo -e  " [  5 ] Change Port Of Some Service"
echo -e  " [  6 ] Webmin Menu"
echo -e  " [  7 ] Check Usage of VPS Ram"
echo -e  " [  8 ] Reboot VPS"
echo -e  " [  9 ] Speedtest VPS"
echo -e  " [ 10 ] Displaying System Information"
echo -e  " [ 11 ] Info Script"
echo -e  " [ 12 ] Check System Error"
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
   pv2ray
   ;;
   3)
   pxray
   ;;
   4)
   add-host
   ;;
   5)
   change
   ;;
   6)
   wbmn
   ;;
   7)
   ram
   ;;
   8)
   reboot
   ;;
   9)
   speedtest
   ;;
   10)
   info
   ;;
   11)
   about
   ;;
   12)
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

#!/bin/bash
clear
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
echo -e "=========================================================================="
echo -e  "           AUTOSCRIPT LITE VERSION MODDED BY JINGGO007" | lolcat
echo -e  "                           VERSION 4" | lolcat
echo -e "=========================================================================="
echo -e "=========================================================================="
echo -e "${green}SSH/OPENVPN${NC}"
echo -e "=========================================================================="
echo -e "[  1 ] CREATE NEW USER "
echo -e "[  2 ] GENERATE TRIAL USER"
echo -e "[  3 ] EXTEND ACCOUNT ACTIVE"
echo -e "[  4 ] DELETE ACTIVE USER"
echo -e "[  5 ] CHECK USER LOGIN"
echo -e "[  6 ] LIST USER INFORMATION"
echo -e "[  7 ] DELETE USER EXPIRED"
echo -e "[  8 ] SET AUTO KILL LOGIN"
echo -e "[  9 ] DISPLAY USER MULTILOGIN"
echo -e "[ 10 ] RESTART SERVICE"
echo -e "=========================================================================="
echo -e "${green}VMESS${NC}"
echo -e "=========================================================================="
echo -e "[ 11 ] CREATE NEW USER"
echo -e "[ 12 ] DELETE ACTIVE USER"
echo -e "[ 13 ] EXTEND ACTIVE USER"
echo -e "[ 14 ] CHECK USER LOGIN"
echo -e "=========================================================================="
echo -e "${green}VLESS${NC}"
echo -e "=========================================================================="
echo -e "[ 15 ] CREATE NEW USER"
echo -e "[ 16 ] DELETE ACTIVE USER"
echo -e "[ 17 ] EXTEND ACTIVE USER"
echo -e "[ 18 ] CHECK USER LOGIN"
echo -e "=========================================================================="
echo -e "${green}TROJAN GFW${NC}"
echo -e "=========================================================================="
echo -e "[ 19 ] CREATE NEW USER"
echo -e "[ 20 ] DELETE ACTIVE USER"
echo -e "[ 21 ] EXTEND ACTIVE USER"
echo -e "[ 22 ] CHECK USER LOGIN"
echo -e "=========================================================================="
echo -e "${green}SYSTEM${NC}"
echo -e "=========================================================================="
echo -e "[ 23 ] ADD/CHANGE DOMAIN VPS"
echo -e "[ 24 ] CHANGE PORT SERVICE"
echo -e "[ 25 ] WEBMIN MENU"
echo -e "[ 26 ] CHECK RAM USAGE"
echo -e "[ 27 ] REBOOT VPS"
echo -e "[ 28 ] SPEEDTEST VPS"
echo -e "[ 29 ] DISPLAY SYSTEM INFORMATION"
echo -e "[ 30 ] INFO SCRIPT"
echo -e "[ 31 ] CHECK SERVICE ERROR"
echo -e "=========================================================================="
echo -e "${green}[  0 ] Exit From Menu${NC}"
echo -e "=========================================================================="
echo -e  "  "
echo -e "\e[1;31m"
read -p  "     Please select an option :  " menu
echo -e "\e[0m"
case $menu in
    1)
	usernew
	;;
	2)
	trial
	;;
	3)
	renew
	;;
	4)
	hapus
	;;
	5)
	cek
	;;
	6)
	member
	;;
	7)
	delete
	;;
	8)
	autokill
	;;
	9)
	ceklim
	;;
	10)
	restart
	;;
    11)
    add-ws
    ;;
    12)
    del-ws
    ;;
    13)
    renew-ws
    ;;
    14)
    cek-ws
    ;;
    15)
    add-vless
    ;;
    16)
    del-vless
    ;;
    17)
    renew-vless
    ;;
    18)
    cek-vless
    ;;
    19)
    add-tr
    ;;
    20)
    del-tr
    ;;
    21)
    renew-tr
    ;;
    22)
    cek-tr
    ;;
    23)
    add-host
    ;;
    24)
    change
    ;;
    25)
    wbmn
    ;;
    26)
    ram
    ;;
    27)
    reboot
    ;;
    28)
    speedtest
    ;;
    29)
    info
    ;;
    30)
    about
    ;;
    31)
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
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
echo ""
echo -e " ═════════════════════════════════════════════" 
echo -e "            XRAY CORE MENU                   " 
echo -e " ═════════════════════════════════════════════" 
echo -e " " 
echo -e "   [ 1 ] Create Xray Account"
echo -e "   [ 2 ] Delete Xray Account"
echo -e "   [ 3 ] Renew Xray Account"
echo -e "   [ 4 ] Check Xray Login"
echo -e "   [ 5 ] Monitor Xray Login"
echo -e "   [ 6 ] Info Xray Login"
echo -e "   [ 0 ] Exit to Menu"
echo -e " ═════════════════════════════════════════════" 
echo -e "\e[1;31m"
read -p "    Please select an option :  "  xray
echo -e "\e[0m"
case $xray in
    1)
    add-xray
    ;;
    2)
    del-xray
    ;;
    3)
    renew-xray
    ;;
    4)
    cek-xray
    ;;
    5)
    monitor-xray
    ;;
    6)
    info-xray
    ;;
    0)
    menu
    ;;
	*)
    echo -e "Please enter an correct number"
    sleep 1
    clear
    mvmess
    ;;
    esac

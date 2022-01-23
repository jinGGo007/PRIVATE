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
echo -e "                      VMESS                   " 
echo -e " ═════════════════════════════════════════════" 
echo -e " " 
echo -e "   [ 1 ] Create Xray Vmess Account"
echo -e "   [ 2 ] Delete Xray Vmess Account"
echo -e "   [ 3 ] Renew Xray Vmess Account"
echo -e "   [ 4 ] Check Xray Vmess User Login "
echo -e "   [ x ] Exit"
echo -e " ═════════════════════════════════════════════" 
echo -e "\e[1;31m"
read -p "    Please select an option :  "  v2ray
echo -e "\e[0m"
case $v2ray in
    1)
    add-xvmess
    ;;
    2)
    del-xvmess
    ;;
    3)
    renew-xvmess
    ;;
    4)
    cek-ws
    ;;
    x)
    menu
    ;;
	*)
    echo -e "Please enter an correct number"
    sleep 1
    clear
    xmvmess
    exit
    ;;
esac

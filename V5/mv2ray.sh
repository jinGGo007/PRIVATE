#!/bin/bash
MYIP=$(wget -qO- ipinfo.io/ip);
echo "Checking VPS"

clear
echo ""
echo -e " ═════════════════════════════════════════════" 
echo -e "                      VMESS                   " 
echo -e " ═════════════════════════════════════════════" 
echo -e " " 
echo -e "   [ 1 ] Create V2ray Account"
echo -e "   [ 2 ] Delete V2ray Websocket Account"
echo -e "   [ 3 ] Renew V2ray Account"
echo -e "   [ 4 ] Check V2ray List"
echo -e "   [ 5 ] Monitor V2ray Login "
echo -e "   [ 6 ] Info V2ray Login "
echo -e "   [ 0 ] Exit to Menu"
echo -e " ═════════════════════════════════════════════" 
echo -e "\e[1;31m"
read -p "    Please select an option :  "  v2ray
echo -e "\e[0m"
case $v2ray in
    1)
    add-v2ray
    ;;
    2)
    del-v2ray
    ;;
    3)
    renew-v2ray
    ;;
    4)
    cek-v2ray
    ;;
    5)
    monitor-v2ray
    ;;
    6)
    info-v2ray
    ;;
    0)
    menu
    ;;
	*)
    echo -e "Please enter an correct number"
    sleep 1
    clear
    mv2ray
    ;;
    esac

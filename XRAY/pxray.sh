#!/bin/bash
clear

echo ""
echo -e " ═════════════════════════════════════════════" 
echo -e "                 PANEL XRAY                  " 
echo -e " ═════════════════════════════════════════════" 
echo -e " " 
echo -e "   [ 1 ] Panel Xray Vmess"
echo -e "   [ 2 ] Panel Xray Vless"
echo -e "   [ 3 ] Panel Xray Vless XTLS"
echo -e "   [ 4 ] Panel Xray Grpc"
echo -e "   [ 5 ] Panel Trojan Go"
echo -e "   [ 0 ] Exit to Menu"
echo -e " ═════════════════════════════════════════════" 
echo -e "\e[1;31m"
read -p "    Please select an option :  "  pxray
echo -e "\e[0m"
case $pxray in
    1)
    mxvmess
    ;;
    2)
    mxvless
    ;;
    3)
    mxtls
    ;;
    4)
    mgrpc
    ;;
    5)
    mxtrojan
    ;;
    0)
    menu
    ;;
	*)
    echo -e "Please enter an correct number"
    sleep 1
    clear
    pxray
    ;;
    esac

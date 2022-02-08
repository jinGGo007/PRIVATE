#!/bin/bash
clear

echo ""
echo -e " ═════════════════════════════════════════════" 
echo -e "                 PANEL V2RAY                  " 
echo -e " ═════════════════════════════════════════════" 
echo -e " " 
echo -e "   [ 1 ] Panel V2ray Vmess"
echo -e "   [ 2 ] Panel V2ray Vless"
echo -e "   [ 3 ] Panel Trojan "
echo -e "   [ 0 ] Exit to Menu"
echo -e " ═════════════════════════════════════════════" 
echo -e "\e[1;31m"
read -p "    Please select an option :  "  pv2ray
echo -e "\e[0m"
case $pv2ray in
    1)
    mvmess
    ;;
    2)
    mvless
    ;;
    3)
    mtrojan
    ;;
    0)
    menu
    ;;
	*)
    echo -e "Please enter an correct number"
    sleep 1
    clear
    pv2ray
    ;;
    esac

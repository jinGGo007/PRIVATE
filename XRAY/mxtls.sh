#!/bin/bash
clear
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'

echo ""
echo -e " ═════════════════════════════════════════════" 
echo -e "             ${green}XRAY VLESS XTLS${NC}                    " 
echo -e " ═════════════════════════════════════════════" 
echo -e " " 
echo -e "   [ 1 ] Create Xray Vless XTLS Account"
echo -e "   [ 2 ] Delete Xray Vless XTLS Account"
echo -e "   [ 3 ] Renew Xray Vless XTLS Account"
echo -e "   [ 4 ] Check User Login Vless XTLS"
echo -e "   [ 0 ] Exit to Menu"
echo -e " ═════════════════════════════════════════════" 
echo -e "\e[1;31m"
read -p "    Please select an option :  "  xtls
echo -e "\e[0m"
case $xtls in
    1)
    add-xtls
    ;;
    2)
    del-xtls
    ;;
    3)
    renew-xtls
    ;;
    4)
    cek-xtls
    ;;
    0)
    menu
    ;;
	*)
    echo -e "Please enter an correct number"
    sleep 1
    clear
    mxtls
    ;;
    esac

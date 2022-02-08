#!/bin/bash
clear
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'

echo ""
echo -e " ═════════════════════════════════════════════" 
echo -e "                ${green}XRAY VLESS${NC}                    " 
echo -e " ═════════════════════════════════════════════" 
echo -e " " 
echo -e "   [ 1 ] Create Xray Vless Account"
echo -e "   [ 2 ] Delete Xray Vless Account"
echo -e "   [ 3 ] Renew Xray Vless Account"
echo -e "   [ 4 ] Check User Login Xray Vless"
echo -e "   [ 0 ] Exit to Menu"
echo -e " ═════════════════════════════════════════════" 
echo -e "\e[1;31m"
read -p "    Please select an option :  "  xvless
echo -e "\e[0m"
case $xvless in
    1)
    add-xvless
    ;;
    2)
    del-xvless
    ;;
    3)
    renew-xless
    ;;
    4)
    cek-xvless
    ;;
    0)
    menu
    ;;
	*)
    echo -e "Please enter an correct number"
    sleep 1
    clear
    mxvless
    ;;
    esac

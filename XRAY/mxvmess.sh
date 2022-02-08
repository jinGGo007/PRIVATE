#!/bin/bash
clear
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'

echo ""
echo -e " ═════════════════════════════════════════════" 
echo -e "                ${green}XRAY VMESS${NC}                    " 
echo -e " ═════════════════════════════════════════════" 
echo -e " " 
echo -e "   [ 1 ] Create Xray Vmess Account"
echo -e "   [ 2 ] Delete Xray Vmess Account"
echo -e "   [ 3 ] Renew Xray Vmess Account"
echo -e "   [ 4 ] Check User Login Xray Vmess"
echo -e "   [ 0 ] Exit to Menu"
echo -e " ═════════════════════════════════════════════" 
echo -e "\e[1;31m"
read -p "    Please select an option :  "  xws
echo -e "\e[0m"
case $xws in
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
    cek-xvmess
    ;;
    0)
    menu
    ;;
	*)
    echo -e "Please enter an correct number"
    sleep 1
    clear
    mxvmess
    ;;
    esac

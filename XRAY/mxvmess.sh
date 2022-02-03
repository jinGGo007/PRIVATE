#!/bin/bash
clear

echo ""
echo -e " ═════════════════════════════════════════════" 
echo -e "                 XRAY VMESS                   " 
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
    add-xws
    ;;
    2)
    del-xws
    ;;
    3)
    renew-xws
    ;;
    4)
    cek-xws
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

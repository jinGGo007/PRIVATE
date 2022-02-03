#!/bin/bash
clear

echo ""
echo -e " ═════════════════════════════════════════════" 
echo -e "                 XRAY VLESS XTLS                   " 
echo -e " ═════════════════════════════════════════════" 
echo -e " " 
echo -e "   [ 1 ] Create Xray Vless XTLS Account"
echo -e "   [ 2 ] Delete Xray Vless XTLS Account"
echo -e "   [ 3 ] Renew Xray Vless XTLS Account"
echo -e "   [ 4 ] Check User Login Vless XTLS"
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
    0)
    menu
    ;;
	*)
    echo -e "Please enter an correct number"
    sleep 1
    clear
    mxvlessxtls
    ;;
    esac

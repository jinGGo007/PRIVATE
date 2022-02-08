#!/bin/bash
clear
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'

echo ""
echo -e " ═════════════════════════════════════════════" 
echo -e "                 ${green}TROJAN GO${NC}                   " 
echo -e " ═════════════════════════════════════════════" 
echo -e " " 
echo -e "   [ 1 ] Create Trojan Go Account"
echo -e "   [ 2 ] Delete Trojan Go Account"
echo -e "   [ 3 ] Renew Trojan Go Account"
echo -e "   [ 4 ] Check User Login Trojan Go"
echo -e "   [ 0 ] Exit to Menu"
echo -e " ═════════════════════════════════════════════" 
echo -e "\e[1;31m"
read -p "    Please select an option :  "  trgo
echo -e "\e[0m"
case $trgo in
    1)
    add-xtrgo
    ;;
    2)
    del-xtrgo
    ;;
    3)
    renew-xtrgo
    ;;
    4)
    cek-xtrgo
    ;;
    0)
    menu
    ;;
	*)
    echo -e "Please enter an correct number"
    sleep 1
    clear
    mxtrgo
    ;;
    esac

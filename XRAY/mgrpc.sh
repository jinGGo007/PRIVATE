#!/bin/bash
clear
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'

echo ""
echo -e " ═════════════════════════════════════════════" 
echo -e "                 ${green}XRAY GRPC${NC}                    " 
echo -e " ═════════════════════════════════════════════" 
echo -e " " 
echo -e "   [ 1 ] Create Xray Grpc Account"
echo -e "   [ 2 ] Delete Xray Grpc Account"
echo -e "   [ 3 ] Renew Xray Grpc Account"
echo -e "   [ 4 ] Check User Xray Grpc Login"
echo -e "   [ 0 ] Exit to Menu"
echo -e " ═════════════════════════════════════════════" 
echo -e "\e[1;31m"
read -p "    Please select an option :  "  grpc
echo -e "\e[0m"
case $grpc in
    1)
    add-grpc
    ;;
    2)
    del-grpc
    ;;
    3)
    renew-grpc
    ;;
    4)
    cek-grpc
    ;;
    0)
    menu
    ;;
	*)
    echo -e "Please enter an correct number"
    sleep 1
    clear
    mgrpc
    ;;
    esac

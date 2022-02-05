#!/bin/bash
clear
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'

echo -e ""
echo ""
echo -e " ═════════════════════════════════════════════" 
echo -e "                  ${green}XRAY VLESS${NC}                     "   
echo -e " ═════════════════════════════════════════════" 
echo -e " " 
echo -e "   [ 1 ] Create Xray Vless Account"
echo -e "   [ 2 ] Delete Xray Vless Account"
echo -e "   [ 3 ] Extending Vless Account Active Life"
echo -e "   [ 0 ] Exit to Menu"
echo -e " ═════════════════════════════════════════════" 
echo -e "\e[1;31m"
read -p "     Please select an option :  "  xray
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
      0)
      menu
      ;;
      *)
      echo -e "Please enter an correct number"
      sleep 1
      clear
      mxray
      ;;
      esac

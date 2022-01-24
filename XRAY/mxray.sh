#!/bin/bash

clear
if [ "${EUID}" -ne 0 ]; then
		echo "You need to run this script as root"
		exit 1
fi
if [ "$(systemd-detect-virt)" == "openvz" ]; then
		echo "OpenVZ is not supported"
		exit 1
fi
clear

echo -e ""
echo ""
echo -e " ═════════════════════════════════════════════" 
echo -e "                XRAY VLESS MENU                   "   
echo -e " ═════════════════════════════════════════════" 
echo -e " " 
echo -e "   [ 1 ] Create Xray Vless Account"
echo -e "   [ 2 ] Delete Xray Vless Account"
echo -e "   [ 3 ] Extending Xray Vless Account Active Life"
echo -e "   [ x ] Exit"
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
      x)
      menu
      ;;
      *)
      echo -e "Please enter an correct number"
      sleep 1
      clear
      mxray
      ;;
      esac

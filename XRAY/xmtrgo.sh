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
echo -e  "  ═══════════════════════════════════════════════" 
echo -e  "                        TROJAN                   " 
echo -e  "  ═══════════════════════════════════════════════" 
echo -e  "  " 
echo -e  "    [ 1 ] Create Trojan Go Account"
echo -e  "    [ 2 ] Delete Trojan Go Account"
echo -e  "    [ 3 ] Extend Trojan Go Account "
echo -e  "    [ 4 ] Check Trojan Go User Login"
echo -e  "    [ x ] Exit" 
echo -e  "  ═══════════════════════════════════════════════" 
echo -e "\e[1;31m"
read -p "     Please select an option :  "  trojan
echo -e "\e[0m"
case $trojan in
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
      x)
      menu
      ;;
      *)
      echo -e "Please enter an correct number"
      sleep 1
      clear
      xmtrgo
      exit
      ;;
  esac

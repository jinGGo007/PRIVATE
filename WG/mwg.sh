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
echo -e " ══════════════════════════════════════════════" 
echo -e "                    WIREGUARD                  " 
echo -e " ══════════════════════════════════════════════" 
echo -e " " 
echo -e "   [ 1 ] Create Wireguard Account"
echo -e "   [ 2 ] Delete Wireguard Account"
echo -e "   [ 3 ] Check User Login Wireguard"
echo -e "   [ 4 ] Extend Wireguard Account Active Life"
echo -e "   [ 5 ] Check Wireguard User Interface"
echo -e " " 
echo -e " ══════════════════════════════════════════════" 
echo -e "  - CTRL C to cancel                           "   
echo -e " ══════════════════════════════════════════════" 
echo -e "\e[1;32m"
read -p "     Please select an option :  "  wg
echo -e "\e[0m"
case $wg in
    1)
    add-wg
    ;;
    2)
    del-wg
    ;;
    3)
    cek-wg
    ;;
    4)
    renew-wg
    ;;
    5)
    wg-show
    ;;
    *)
    echo -e "Please enter an correct number"
    sleep 2
    clear
    mwg
    exit
    ;;
esac

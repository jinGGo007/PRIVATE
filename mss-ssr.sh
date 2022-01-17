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
echo -e " ═════════════════════════════════════════"
echo -e "      ShadowsocksR & Shadowsocks OBFS     " 
echo -e " ═════════════════════════════════════════"
echo -e " " 
echo -e "   [ 1 ]  Create SSR Account"
echo -e "   [ 2 ]  Delete SSR Account"
echo -e "   [ 3 ]  Extend SSR Account Active Life"
echo -e "   [ 4 ]  Show Other SSR Menu"
echo -e "   [ 5 ]  Create Shadowsocks Account"
echo -e "   [ 6 ]  Delete Shadowsocks Account"
echo -e "   [ 7 ]  Extend Shadowsocks Account"
echo -e "   [ 8 ]  Check User Login Shadowsocks"
echo -e " " 
echo -e " ═════════════════════════════════════════" 
echo -e "  - CTRL C to cancel                      "  
echo -e " ═════════════════════════════════════════" 
echo -e ""
read -p "     Please Input Number  :  "  ssr
echo -e ""
case $ssr in
1)
add-ssr
;;
2)
del-ssr
;;
3)
renew-ssr
;;
4)
ssr
;;
5)
add-ss
;;
6)
del-ss
;;
7)
renew-ss
;;
8)
cek-ss
;;
*)
echo -e "Please enter an correct number"
sleep 2
clear
mss-ssr
exit
;;
esac

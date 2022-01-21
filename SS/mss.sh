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
echo -e "            Shadowsocks OBFS     " 
echo -e " ═════════════════════════════════════════"
echo -e " " 
echo -e "   [ 1 ]  Create Shadowsocks Account"
echo -e "   [ 2 ]  Delete Shadowsocks Account"
echo -e "   [ 3 ]  Extend Shadowsocks Account"
echo -e "   [ 4 ]  Check User Login Shadowsocks"
echo -e " " 
echo -e " ═════════════════════════════════════════" 
echo -e "  - CTRL C to cancel                      "  
echo -e " ═════════════════════════════════════════" 
echo -e ""
read -p "     Please Input Number  :  "  ss
echo -e ""
case $ss in
1)
add-ss
;;
2)
del-ss
;;
3)
renew-ss
;;
4)
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

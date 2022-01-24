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
echo -e "           XRAY VMESS/VLESS MENU                   "   
echo -e " ═════════════════════════════════════════════" 
echo -e " " 
echo -e "   [ 1 ] Create Xray Vmess Account"
echo -e "   [ 2 ] Delete Xray Vmess Account"
echo -e "   [ 3 ] Extending Xray VMESS Account "
echo -e "   [ 4 ] Check User Login Xray Vmess Account "
echo -e "   [ 5 ] Create Xray Vless Account"
echo -e "   [ 6 ] Delete Xray Vless Account"
echo -e "   [ 7 ] Extending Xray Vless Account "
echo -e "   [ 8 ] Check User Login Xray Vless Account "
echo -e "   [ x ] Exit"
echo -e " ═════════════════════════════════════════════" 
echo -e "\e[1;31m"
read -p "     Please select an option :  "  mxray
echo -e "\e[0m"
case $mxray in
;;
1)
add-xvmess
;;
2)
del-xvmess
;;
3)
renew-xvmess
;;
4)
cek-xvmess
;;
5)
add-xvless
;;
6)
del-xvless
;;
7)
renew-xvless
;;
8)
cek-xvless
;;
x)
exit
;;
*)
echo " Please enter an correct number!!"
sleep 1
clear
mxray
;;
esac



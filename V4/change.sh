#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(wget -qO- icanhazip.com);
echo "Checking VPS"
clear
echo -e ""
echo -e "======================================"
echo -e ""
echo -e "     [ 1 ]  Change Port Stunnel4"
echo -e "     [ 2 ]  Change Port OpenVPN"
echo -e "     [ 3 ]  Change Port Vmess"
echo -e "     [ 4 ]  Change Port Vless"
echo -e "     [ 5 ]  Change Port Trojan"
echo -e "     [ 6 ]  Change Port Squid"
echo -e "     [ 7 ]  Change Port Xray Vless"
echo -e "     [ 8 ]  Change Port Xray Vless Xtls"
echo -e "     [ 9 ]  Change Port Xray Vmess"
echo -e "     [10 ]  Change Port Trojan Go"
echo -e "     [ 0 ]  Exit to Menu"
echo -e "======================================"
echo -e "\e[1;31m"
read -p "     Select From Options [1-8 or x] :  " port
echo -e "\e[0m"
case $port in
1)
port-ssl
;;
2)
port-ovpn
;;
3)
port-ws
;;
4)
port-vless
;;
5)
port-tr
;;
6)
port-squid
;;
7)
port-squid
;;
8)
port-xvless
;;
9)
port-xray
;;
10)
port-trgo
;;
0)
clear
menu
;;
*)
echo "Please enter an correct number"
sleep 1
clear
change
;;
esac
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu
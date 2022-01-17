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
echo -e  "  ════════════════════════════════════════════════════════════ " 
echo -e  "                       SSH & OpenVPN Menu                     " 
echo -e  "  ════════════════════════════════════════════════════════════ " 
echo -e  "  " 
echo -e  "    [  1 ] Create SSH & OpenVPN Account"
echo -e  "    [  2 ] Generate SSH & OpenVPN Trial Account"
echo -e  "    [  3 ] Extend SSH & OpenVPN Account Active Life"
echo -e  "    [  4 ] Delete SSH & OpenVPN Account"
echo -e  "    [  5 ] Check User Login SSH & OpenVPN"
echo -e  "    [  6 ] List Member SSH & OpenVPN"
echo -e  "    [  7 ] Delete User Expired SSH & OpenVPN"
echo -e  "    [  8 ] Set up Autokill SSH"
echo -e  "    [  9 ] Displays Users Who Do Multi Login SSH"
echo -e  "    [ 10 ] Restart Service Dropbear, Squid3, OpenVPN dan SSH"
echo -e  "  "
echo -e  "  ════════════════════════════════════════════════════════════ " 
echo -e  "                                                              " 
echo -e  "    - CTRL C to cancel                                        " 
echo -e  "  ════════════════════════════════════════════════════════════ " 
echo -e "\e[1;31m"
read -p "            Please Input Number :  " ssh
echo -e "\e[0m"
case $ssh in
	1)
	usernew
	;;
	2)
	trial
	;;
	3)
	renew
	;;
	4)
	deluser
	;;
	5)
	cek
	;;
	6)
	member
	;;
	7)
	delete
	;;
	8)
	autokill
	;;
	9)
	ceklim
	;;
	10)
	restart
	;;
	*)
	echo -e "Please enter an correct number"
	sleep 2
	clear
	mssh
	exit
	;;
	esac

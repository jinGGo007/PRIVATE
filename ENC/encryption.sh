#!/bin/bash

#update && upgrade
apt update 
apt upgrade -y
apt install -y bzip2 gzip coreutils screen curl
sleep 2
clear

# Script Access 
MYIP=$(wget -qO- icanhazip.com);

echo -e "${green}CHECKING SCRIPT ACCESS${NC}"
sleep 2
IZIN=$( curl https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/IP/REGIP | grep $MYIP )
if [ $MYIP = $IZIN ]; then
    echo -e ""
    echo -e "${green}ACCESS GRANTED...${NC}"
    sleep 2
else
	echo -e ""
    echo -e "${green}ACCESS DENIED...PM TELEGRAM OWNER${NC}"
    sleep 2
    rm -f encryption.sh
    exit 1
fi
clear
echo -e "============================================="
echo -e " ${green} INSTALLING ENC${NC}"
echo -e "============================================="
sleep 2
cd /usr/bin
wget -O enc "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/ENC/enc.sh"
chmod +x enc
cd
sleep 2
clear
sleep 2
echo -e "============================================="
echo -e " ${green} INSTALLATION ENC COMPELTE ${NC}"
echo -e "============================================="
rm -f encryption.sh
read -n 1 -r -s -p $'Press any key to reboot...\n';reboot
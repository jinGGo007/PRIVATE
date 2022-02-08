#!/bin/bash                                                                             
clear
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'                                                                              
                                                                                      

status="$(systemctl show ssh.service --no-page)"                                   
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)                     
if [ "${status_text}" == "active" ]                                                     
then                                                                                    
echo -e " SSH                  : SSH Service is "$green"running"$NC""                  
else                                                                                    
echo -e " SSh                  : SSH Service is "$red"not running (Error)"$NC""        
fi
status="$(systemctl show stunnel4.service --no-page)"                                   
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)                     
if [ "${status_text}" == "active" ]                                                     
then                                                                                    
echo -e " Stunnel              : Stunnel Service is "$green"running"$NC""                  
else                                                                                    
echo -e " Stunnel              : Stunnel Service is "$red"not running (Error)"$NC""        
fi                                                                                
status="$(systemctl show dropbear.service --no-page)"                                   
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)                     
if [ "${status_text}" == "active" ]                                                     
then                                                                                    
echo -e " DropBear             : DropBear Service is "$green"running"$NC""                  
else                                                                                    
echo -e " DropBear             : DropBear Service is "$red"not running (Error)"$NC""        
fi                                                                                      
status="$(systemctl show v2ray@none.service --no-page)"                                 
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)                     
if [ "${status_text}" == "active" ]                                                     
then                                                                                    
echo -e " V2ray Non TLS        : V2ray Non TLS Service is "$green"running"$NC""              
else                                                                                    
echo -e " V2ray Non TLS        : V2ray Non TLS Service is "$red"not running (Error)"$NC""    
fi                                                                                      
status="$(systemctl show v2ray.service --no-page)"                                      
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)                     
if [ "${status_text}" == "active" ]                                                     
then                                                                                    
echo -e " V2ray TLS            : V2ray TLS Service is "$green"running"$NC""                
else                                                                                    
echo -e " V2ray TLS            : V2ray TLS Service is "$red"not running (Error)"$NC""      
fi
status="$(systemctl show v2ray@vless.service --no-page)"                                      
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)                     
if [ "${status_text}" == "active" ]                                                     
then                                                                                    
echo -e " Vless TLS            : Vless TLS Service is "$green"running"$NC""                
else                                                                                     
echo -e " Vless TLS            : Vless TLS Service is "$red"not running (Error)"$NC""      
fi
status="$(systemctl show v2ray@vnone.service --no-page)"                                      
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)                     
if [ "${status_text}" == "active" ]                                                     
then                                                                                    
echo -e " Vless Non TLS        : Vless Non TLS Service is "$green"running"$NC""                
else                                                                                    
echo -e " Vless Non TLS        : Vless Non TLS Service is "$red"not running (Error)"$NC""      
fi
status="$(systemctl show trojan --no-page)"                                      
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)                     
if [ "${status_text}" == "active" ]                                                     
then                                                                                    
echo -e " Trojan               : Trojan Service is "$green"running"$NC""                
else                                                                                    
echo -e " Trojan               : Trojan Service is "$red"not running (Error)"$NC""      
fi
status="$(systemctl show squid.service --no-page)"                                      
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)                     
if [ "${status_text}" == "active" ]                                                     
then                                                                                    
echo -e " Squid                : Squid Service is "$green"running"$NC""                
else                                                                                    
echo -e " Squid                : Squid Service is "$red"not running (Error)"$NC""      
fi
status="$(systemctl show openvpn.service --no-page)"                                      
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)                     
if [ "${status_text}" == "active" ]                                                     
then                                                                                    
echo -e " Openvpn              : Openvpn Service is "$green"running"$NC""                
else                                                                                      
echo -e " Openvpn              : Openvpn Service is "$red"not running (Error)"$NC""      
fi
status="$(systemctl show nginx.service --no-page)"                                      
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)                     
if [ "${status_text}" == "active" ]                                                     
then                                                                                    
echo -e " Nginx                : Nginx Service is "$green"running"$NC""                
else                                                                                    
echo -e " Nginx                : Nginx Service is "$red"not running (Error)"$NC""      
fi
status="$(systemctl show ohp.service --no-page)"                                   
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)                     
if [ "${status_text}" == "active" ]                                                     
then                                                                                    
echo -e " OHP                  : OHP Service is "$green"running"$NC""                  
else                                                                                    
echo -e " OHP                  : OHP Service is "$red"not running (Error)"$NC""        
fi
status="$(systemctl show edussh-nontls.service --no-page)"                                   
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)                     
if [ "${status_text}" == "active" ]                                                     
then                                                                                    
echo -e " SSH WS               : SSH WS Service is "$green"running"$NC""                  
else                                                                                    
echo -e " SSH WS               : SSH WS Service is "$red"not running (Error)"$NC""        
fi
status="$(systemctl show edu-ovpn.service --no-page)"                                   
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)                     
if [ "${status_text}" == "active" ]                                                     
then                                                                                    
echo -e " OVPN WS              : OVPN WS Service is "$green"running"$NC""                  
else                                                                                    
echo -e " OVPN WS              : OVPN WS Service is "$red"not running (Error)"$NC""        
fi
status="$(systemctl show xtls.service --no-page)"                                   
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)                     
if [ "${status_text}" == "active" ]                                                     
then                                                                                    
echo -e " XRAY VLESS XTLS      : XRAY VLESS XTLS Service is "$green"running"$NC""                  
else                                                                                    
echo -e " XRAY VLESS XTLS      : XRAY VLESS XTLS Service is "$red"not running (Error)"$NC""        
fi
status="$(systemctl show vmess-grpc.service --no-page)"                                   
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)                     
if [ "${status_text}" == "active" ]                                                     
then                                                                                    
echo -e " XRAY VMESS GRPC      : XRAY VMESS GRPC Service is "$green"running"$NC""                  
else                                                                                    
echo -e " XRAY VMESS GRPC      : XRAY VMESS GRPC Service is "$red"not running (Error)"$NC""        
fi
status="$(systemctl show vless-grpc.service --no-page)"                                   
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)                     
if [ "${status_text}" == "active" ]                                                     
then                                                                                    
echo -e " XRAY VLESS GRPC      : XRAY VLESS GRPC Service is "$green"running"$NC""                  
else                                                                                    
echo -e " XRAY VLESS GRPC      : XRAY VLESS GRPC Service is "$red"not running (Error)"$NC""   
fi 
status="$(systemctl show xr-vl-tls.service --no-page)"                                   
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)                     
if [ "${status_text}" == "active" ]                                                     
then                                                                                    
echo -e " XRAY VLESS TCP       : XRAY VLESS TCP Service is "$green"running"$NC""                  
else                                                                                    
echo -e " XRAY VLESS TCP       : XRAY VLESS TCP Service is "$red"not running (Error)"$NC""        
fi    
status="$(systemctl show xr-vl-ntls.service --no-page)"                                   
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)                     
if [ "${status_text}" == "active" ]                                                     
then                                                                                    
echo -e " XRAY VLESS None TCP  : XRAY VLESS None TCP Service is "$green"running"$NC""                  
else                                                                                    
echo -e " XRAY VLESS None TCP  : XRAY VLESS None TCP Service is "$red"not running (Error)"$NC""        
fi    
status="$(systemctl show xr-vm-ntls.service --no-page)"                                   
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)                     
if [ "${status_text}" == "active" ]                                                     
then                                                                                    
echo -e " XRAY VMESS NONE TCP  : XRAY VMESS NONE TCP Service is "$green"running"$NC""                  
else                                                                                    
echo -e " XRAY VMESS NONE TCP  : XRAY VMESS NONE TCP Service is "$red"not running (Error)"$NC""        
fi 
status="$(systemctl show xr-vm-tls.service --no-page)"                                   
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)                     
if [ "${status_text}" == "active" ]                                                     
then                                                                                    
echo -e " XRAY VMESS TCP       : XRAY VMESS TCP Service is "$green"running"$NC""                  
else                                                                                    
echo -e " XRAY VMESS TCP       : XRAY VMESS TCP Service is "$red"not running (Error)"$NC""        
fi 
status="$(systemctl show x-tr.service --no-page)"                                   
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)                     
if [ "${status_text}" == "active" ]                                                     
then                                                                                    
echo -e " TROJAN GO            : TROJAN GO Service is "$green"running"$NC""                  
else                                                                                    
echo -e " TROJAN GOP           : TROJAN GO Service is "$red"not running (Error)"$NC""        
fi 
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu
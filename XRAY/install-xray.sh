#!/bin/bash
# XRay Installation
# ==================================
MYIP=$(wget -qO- ipinfo.io/ip);
echo "Checking VPS"
clear

domain=$(cat /etc/v2ray/domain)

# // Make Main Directory
mkdir -p /usr/local/xray/

# // Installation XRay Core
wget -q -O /usr/local/xray/xray "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/xray-mini" 
wget -q -O /usr/local/xray/geosite.dat "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/geosite.dat"
wget -q -O /usr/local/xray/geoip.dat "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/geoip.dat"
chmod +x /usr/local/xray/xray

# // Make XRay Mini Root Folder
mkdir -p /etc/xray/
chmod 775 /etc/xray/

# // Installing XRay Mini Service


cat > /etc/systemd/system/xtls.service << EOF
[Unit]
Description=XRay XTLS Service
Documentation=https://speedtest.net https://github.com/XTLS/Xray-core
After=network.target nss-lookup.target

[Service]
User=root
NoNewPrivileges=true
ExecStart=/usr/local/xray/xray -config /etc/xray/xrayxtls.json
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target
EOF

# // Installing Xray
wget https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/plugin-xray.sh && chmod +x plugin-xray.sh && ./plugin-xray.sh
rm -f /root/plugin-xray.sh

service squid start
uuid=$(cat /proc/sys/kernel/random/uuid)
password="$(tr -dc 'a-z0-9A-Z' </dev/urandom | head -c 16)"

cat > /etc/xray/xrayxtls.json << END
{
  "inbounds": [
    {
      "port": 88,
      "protocol": "vless",
      "settings": {
        "clients": [
          {
            "id": "${uuid}",
            "flow": "xtls-rprx-direct"
#XRay
          }
        ],
        "decryption": "none",
        "fallbacks": [
          {
            "dest": 60000,
            "alpn": "",
            "xver": 1
          },
          {
            "dest": 60001,
            "alpn": "h2",
            "xver": 1
          }
        ]
      },
      "streamSettings": {
        "network": "tcp",
        "security": "xtls",
        "xtlsSettings": {
          "minVersion": "1.2",
          "certificates": [
            {
              "certificateFile": "/etc/xray/xray.crt",
              "keyFile": "/etc/xray/xray.key"
            }
          ]
        }
      },
      "sniffing": {
        "enabled": true,
        "destOverride": [
          "http",
          "tls"
        ]
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom"
    }
  ]
}
END

cat > /etc/xray/vlessgrpc.json << END
{
    "log": {
            "access": "/var/log/xray/access5.log",
        "error": "/var/log/xray/error.log",
        "loglevel": "info"
    },
    "inbounds": [
        {
            "port": 880,
            "protocol": "vless",
            "settings": {
                "clients": [
                    {
                        "id": "${uuid}"
#vlessgrpc
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "gun",
                "security": "tls",
                "tlsSettings": {
                    "serverName": "${domain}",
                    "alpn": [
                        "h2"
                    ],
                    "certificates": [
                        {
                            "certificateFile": "/etc/xray/xray.crt",
                            "keyFile": "/etc/xray/xray.key"
                        }
                    ]
                },
                "grpcSettings": {
                    "serviceName": "GunService"
                }
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom",
            "tag": "direct"
        }
    ]
}
END

cat > /etc/systemd/system/vless-grpc.service << EOF
[Unit]
Description=XRay VMess GRPC Service
Documentation=https://speedtest.net https://github.com/XTLS/Xray-core
After=network.target nss-lookup.target

[Service]
User=root
NoNewPrivileges=true
ExecStart=/usr/local/xray/xray -config /etc/xray/vlessgrpc.json
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target
EOF

iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 88 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 88 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 880 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 880 -j ACCEPT
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save
netfilter-persistent reload
systemctl daemon-reload

systemctl enable xtls.service
systemctl start xtls.service
systemctl enable vless-grpc.service
systemctl start vless-grpc.service

cd /usr/bin

wget -O pv2ray "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/pv2ray.sh"
wget -O pxray "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/pxray.sh"
wget -O mxtls "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/mxtls.sh"
wget -O mxvmess "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/mxvmess.sh"
wget -O mxvless "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/mxvless.sh"
wget -O mxtrgo "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/mxtrgo.sh"
wget -O mgrpc "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/mgrpc.sh"
wget -O add-xtls "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/add-xtls.sh"
wget -O add-xvmess "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/add-xvmess.sh"
wget -O add-xvless "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/add-xvless.sh"
wget -O add-xtrgo "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/add-xtrgo"
wget -O add-grpc "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/add-grpc.sh"
wget -O del-xtls "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/del-xtls.sh"
wget -O del-xvmess "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/del-xvmess.sh"
wget -O del-xvless "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/del-xvless.sh"
wget -O del-xtrgo "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/del-xtrgo.sh"
wget -O del-xgrpc "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/del-grpc.sh"
wget -O cek-xtls "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/cek-xtls.sh"
wget -O cek-xvmess "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/cek-xvmess.sh"
wget -O cek-xvless "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/cek-xvless.sh"
wget -O cek-xtrgo "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/cek-xtrgo.sh"
wget -O cek-grpc "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/cek-grpc.sh"
wget -O renew-xtls "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/renew-xtls.sh"
wget -O renew-xvmess "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/renew-xvmess.sh"
wget -O renew-xvless "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/renew-xvless.sh"
wget -O renew-xtrgo "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/renew-xtrgo.sh"
wget -O renew-grpc "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/renew-grpc.sh"
wget -O port-xtls "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/port-xtls.sh"
wget -O port-xvmess "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/port-xvmess.sh"
wget -O port-xvless "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/port-xvless.sh"
wget -O port-xtrgo "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/port-xtrgo.sh"
wget -O port-grpc "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/port-grpc.sh"
chmod +x pv2ray
chmod +x pxray
chmod +x mxtls
chmod +x mxvmess
chmod +x mxvless
chmod +x mxtrgo
chmod +x mgrpc
chmod +x add-xtls
chmod +x add-xvmess
chmod +x add-xvless
chmod +x add-xtrgo
chmod +x add-grpc
chmod +x del-xtls
chmod +x del-xvmess
chmod +x del-xvless
chmod +x del-xtrgo
chmod +x del-xgrpc
chmod +x cek-xtls
chmod +x cek-xvmess
chmod +x cek-xvless
chmod +x cek-xtrgo
chmod +x cek-grpc
chmod +x renew-xtls
chmod +x renew-xvmess
chmod +x renew-xvless
chmod +x renew-xtrgo
chmod +x renew-grpc
chmod +x port-xtls
chmod +x port-xvmess
chmod +x port-xvless
chmod +x port-xtrgo
chmod +x port-grpc
cd
rm -f install-xray.sh

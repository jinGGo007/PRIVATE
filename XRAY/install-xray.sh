#!/bin/bash
# XRay Installation

# // Update & Installing Requirement
apt update -y
apt upgrade -y
apt install socat -y
apt install python -y
apt install curl -y
apt install wget -y
apt install sed -y
apt install nano -y
apt install python3 -y

# // Make Main Directory
mkdir -p /usr/local/jinggo/

# // Installation XRay Core
wget -q -O /usr/local/jinggo/xray-mini "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/xray-mini" 
chmod +x /usr/local/jinggo/xray-mini

# // Make XRay Mini Root Folder
mkdir -p /etc/xray-mini/
chmod 775 /etc/xray-mini/

# // Installing XRay Mini Service
cat > /etc/systemd/system/xray-mini.service << EOF
[Unit]
Description=XRay-Mini Service ( %i )
Documentation=https://github.com/XTLS/Xray-core
After=network.target nss-lookup.target

[Service]
User=root
NoNewPrivileges=true
ExecStart=/usr/local/jinggo/xray-mini -config /etc/xray-mini/vless-direct.json
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target
EOF

uuid=$(cat /proc/sys/kernel/random/uuid)

# // Vless Direct
cat > /etc/xray-mini/vless-direct.json << END
{
  "inbounds": [
    {
      "port": 6769,
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
              "certificateFile": "/etc/v2ray/v2ray.crt",
              "keyFile": "/etc/v2ray/v2ray.key"
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

# // Enable & Start Service
systemctl enable xray-mini.service
systemctl start xray-mini.service

# // Downloading Menu
cd /usr/bin
wget -O mxray "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/mxray.sh"
wget -O add-xray "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/add-xray.sh"
wget -O del-xray "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/del-xray.sh"
wget -O renew-xray "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/renew-xray.sh"
wget -O port-xray "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/port-xray.sh"
chmod +x mxray
chmod +x add-xray
chmod +x del-xray
chmod +x renew-xray
chmod +x port-xray
cd
# // Remove Not Used Files
rm -f install-xray.sh
clear

# // Installation XRay Core
wget -q -O /usr/local/xray/xray "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/xray-mini" 
wget -q -O /usr/local/xray/geosite.dat "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/geosite.dat"
wget -q -O /usr/local/xray/geoip.dat "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/geoip.dat"
chmod +x /usr/local/xray/xray

# // Make XRay Mini Root Folder
mkdir -p /etc/xray/
chmod 775 /etc/xray/

# // Installing Xray
wget https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/plugin-xray.sh && chmod +x plugin-xray.sh && ./plugin-xray.sh
rm -f /root/plugin-xray.sh
uuid=$(cat /proc/sys/kernel/random/uuid)
password="$(tr -dc 'a-z0-9A-Z' </dev/urandom | head -c 16)"

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

cat > /etc/xray/vlessgrpc.json << END
{
    "log": {
            "access": "/var/log/xray/access5.log",
        "error": "/var/log/xray/error.log",
        "loglevel": "info"
    },
    "inbounds": [
        {
            "port": 6969,
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

iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 6969 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 6969 -j ACCEPT
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save
netfilter-persistent reload
systemctl daemon-reload
systemctl enable vless-grpc.service
systemctl start vless-grpc.service
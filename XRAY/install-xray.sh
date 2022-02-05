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
cat > /etc/systemd/system/xray-mini@.service << EOF
[Unit]
Description=XRay-Mini Service ( %i )
Documentation=https://github.com/XTLS/Xray-core
After=network.target nss-lookup.target

[Service]
User=root
NoNewPrivileges=true
ExecStart=/usr/local/jinggo/xray-mini -config /etc/xray-mini/%i.json
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target
EOF

# // String
ssl_path_crt="/etc/v2ray/v2ray.crt"
ssl_path_key="/etc/v2ray/v2ray.key"
Port1=8181
Port2=6769
uuid=$(cat /proc/sys/kernel/random/uuid)

# // Vless Splice
cat > /etc/xray-mini/vless-splice.json << END
{
  "inbounds": [
    {
      "port": ${Port2},
      "protocol": "vless",
      "settings": {
        "clients": [
          {
            "id": "${uuid}",
            "flow": "xtls-rprx-splice"
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
              "certificateFile": "${ssl_path_crt}",
              "keyFile": "${ssl_path_key}"
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

# // Vless Direct
cat > /etc/xray-mini/vless-direct.json << END
{
  "inbounds": [
    {
      "port": ${Port2},
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
              "certificateFile": "${ssl_path_crt}",
              "keyFile": "${ssl_path_key}"
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
systemctl enable xray-mini@vless-direct
systemctl start xray-mini@vless-direct
systemctl enable xray-mini@vless-splice
systemctl start xray-mini@vless-splice

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

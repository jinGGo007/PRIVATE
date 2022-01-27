#!/bin/bash
# Xray Auto Setup 
# =========================

MYIP=$(wget -qO- ipinfo.io/ip);
echo "Checking VPS"
sleep 2
clear

domain=$(cat /etc/rare/xray/domain)
# Uuid Service
uuid=$(cat /proc/sys/kernel/random/uuid)
echo -e "\e[0;32m XRAY CORE VPS AutoScript by IANVPN\e[0m"
echo -e "\e[0;32m TELEGRAM @IanVPN\e[0m"
sleep 5
# INSTALL XRAY
wget -c -P /etc/rare/xray/ "https://github.com/XTLS/Xray-core/releases/download/v1.4.5/Xray-linux-64.zip"
unzip -o /etc/rare/xray/Xray-linux-64.zip -d /etc/rare/xray 
rm -rf /etc/rare/xray/Xray-linux-64.zip
chmod 655 /etc/rare/xray/xray
# XRay boot service
cat <<EOF >/etc/systemd/system/xray.service
[Unit]
Description=Xray - A unified platform for anti-censorship
# Documentation=https://v2ray.com https://guide.v2fly.org
After=network.target nss-lookup.target
Wants=network-online.target

[Service]
Type=simple
User=root
CapabilityBoundingSet=CAP_NET_BIND_SERVICE CAP_NET_RAW
NoNewPrivileges=yes
ExecStart=/etc/rare/xray/xray run -confdir /etc/rare/xray/conf
Restart=on-failure
RestartPreventExitStatus=23


[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl enable xray.service
rm -rf /etc/rare/xray/conf/*
cat <<EOF >/etc/rare/xray/conf/00_log.json
{
  "log": {
    "access": "/var/log/xray/access.log",
    "error": "/var/log/xray/error.log",
    "loglevel": "warning"
  }
}
EOF
cat <<EOF >/etc/rare/xray/conf/10_ipv4_outbounds.json
{
    "outbounds":[
        {
            "protocol":"freedom",
            "settings":{
                "domainStrategy":"UseIPv4"
            },
            "tag":"IPv4-out"
        },
        {
            "protocol":"freedom",
            "settings":{
                "domainStrategy":"UseIPv6"
            },
            "tag":"IPv6-out"
        },
        {
            "protocol":"blackhole",
            "tag":"blackhole-out"
        }
    ]
}
EOF
cat <<EOF >/etc/rare/xray/conf/11_dns.json
{
    "dns": {
        "servers": [
          "localhost"
        ]
  }
}
EOF
cat <<EOF >/etc/rare/xray/conf/02_VLESS_TCP_inbounds.json
{
  "inbounds": [
    {
      "port": 80,
      "protocol": "vless",
      "tag": "VLESSTCP",
      "settings": {
        "clients": [],
        "decryption": "none",
        "fallbacks": [
          {
            "dest": 31296,
            "xver": 1
          },
          {
            "alpn": "h2",
            "dest": 31302,
            "xver": 0
          },
          {
            "path": "/xrayws",
            "dest": 31297,
            "xver": 1
          },
          {
            "path": "/xrayvws",
            "dest": 31299,
            "xver": 1
          }
        ]
      },
      "streamSettings": {
        "network": "tcp",
        "security": "xtls",
        "xtlsSettings": {
          "minVersion": "1.2",
          "alpn": [
            "http/1.1",
            "h2"
          ],
          "certificates": [
            {
              "certificateFile": "/etc/rare/xray/xray.crt",
              "keyFile": "/etc/rare/xray/xray.key",
              "ocspStapling": 3600,
              "usage": "encipherment"
            }
          ]
        }
      }
    }
  ]
}
EOF
cat <<EOF >/etc/rare/xray/conf/03_VLESS_WS_inbounds.json
{
  "inbounds": [
    {
      "port": 31297,
      "listen": "127.0.0.1",
      "protocol": "vless",
      "tag": "VLESSWS",
      "settings": {
        "clients": [],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "ws",
        "security": "none",
        "wsSettings": {
          "acceptProxyProtocol": true,
          "path": "/xrayws"
        }
      }
    }
  ]
}
EOF
cat <<EOF >/etc/rare/xray/conf/04_trojan_gRPC_inbounds.json
{
    "inbounds": [
        {
            "port": 31304,
            "listen": "127.0.0.1",
            "protocol": "trojan",
            "tag": "trojangRPCTCP",
            "settings": {
                "clients": [
                    {
                        "password": "9dcc73ba-c90a-4de9-be35-be3da0129768",
                        "email": "xmy01.vpnshopee.xyz_trojan_gRPC"
                    }
                ],
                "fallbacks": [
                    {
                        "dest": "31300"
                    }
                ]
            },
            "streamSettings": {
                "network": "grpc",
                "grpcSettings": {
                    "serviceName": "xraytrojangrpc"
                }
            }
        }
    ]
}
EOF
cat <<EOF >/etc/rare/xray/conf/04_trojan_TCP_inbounds.json
{
  "inbounds": [
    {
      "port": 31296,
      "listen": "127.0.0.1",
      "protocol": "trojan",
      "tag": "trojanTCP",
      "settings": {
        "clients": [],
        "fallbacks": [
          {
            "dest": "31300"
          }
        ]
      },
      "streamSettings": {
        "network": "tcp",
        "security": "none",
        "tcpSettings": {
          "acceptProxyProtocol": true
        }
      }
    }
  ]
}
EOF
cat <<EOF >/etc/rare/xray/conf/05_VMess_WS_inbounds.json
{
  "inbounds": [
    {
      "listen": "127.0.0.1",
      "port": 31299,
      "protocol": "vmess",
      "tag": "VMessWS",
      "settings": {
        "clients": []
      },
      "streamSettings": {
        "network": "ws",
        "security": "none",
        "wsSettings": {
          "acceptProxyProtocol": true,
          "path": "/xrayvws"
        }
      }
    }
  ]
}
EOF
cat <<EOF >/etc/rare/xray/conf/06_VLESS_gRPC_inbounds.json
{
    "inbounds":[
    {
        "port": 31301,
        "listen": "127.0.0.1",
        "protocol": "vless",
        "tag":"VLESSGRPC",
        "settings": {
            "clients": [],
            "decryption": "none"
        },
        "streamSettings": {
            "network": "grpc",
            "grpcSettings": {
                "serviceName": "xraygrpc"
            }
        }
    }
]
}
EOF
# xray
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 31301 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 31299 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 31296 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 31304 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 31297 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 80 -j ACCEPT
# xray
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 31301 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 31299 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 31296 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 31304 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 31297 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 80 -j ACCEPT
iptables-save >/etc/iptables.rules.v4
netfilter-persistent save
netfilter-persistent reload
systemctl daemon-reload

# Starting
systemctl daemon-reload
systemctl restart xray
systemctl enable xray
systemctl restart xray.service
systemctl enable xray.service

cd /usr/bin
wget -O mxray "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/add-xray.sh"
wget -O add-xray "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/add-xray.sh"
wget -O del-xray "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/del-xray.sh"
wget -O renew-xray "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/renew-xray.sh"
wget -O cek-xray "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/cek-xray.sh"
wget -O info-xray "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/info-xray.sh"
wget -O monitor-xray "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/monitor-xray.sh"
chmod +x mxray
chmod +x add-xray
chmod +x del-xray
chmod +x renew-xray
chmod +x cek-xray
chmod +x info-xray
chmod +x monitor-xray
cd
systemctl daemon-reload
systemctl restart nginx
systemctl restart xray
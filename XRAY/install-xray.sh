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
cat > /etc/systemd/system/xr-vm-tls.service << EOF
[Unit]
Description=XRay TLS Service
Documentation=https://speedtest.net https://github.com/XTLS/Xray-core
After=network.target nss-lookup.target

[Service]
User=root
NoNewPrivileges=true
ExecStart=/usr/local/xray/xray -config /etc/xray/vmesstls.json
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target
EOF

cat > /etc/systemd/system/xr-vm-ntls.service << EOF
[Unit]
Description=XRay NTLS Service
Documentation=https://speedtest.net https://github.com/XTLS/Xray-core
After=network.target nss-lookup.target

[Service]
User=root
NoNewPrivileges=true
ExecStart=/usr/local/xray/xray -config /etc/xray/vmessnone.json
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target
EOF

cat > /etc/systemd/system/xr-vl-tls.service << EOF
[Unit]
Description=XRay VLess TLS Service
Documentation=https://speedtest.net https://github.com/XTLS/Xray-core
After=network.target nss-lookup.target

[Service]
User=root
NoNewPrivileges=true
ExecStart=/usr/local/xray/xray -config /etc/xray/vlesstls.json
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target
EOF

cat > /etc/systemd/system/xr-vl-ntls.service << EOF
[Unit]
Description=XRay VLess NTLS Service
Documentation=https://speedtest.net https://github.com/XTLS/Xray-core
After=network.target nss-lookup.target

[Service]
User=root
NoNewPrivileges=true
ExecStart=/usr/local/xray/xray -config /etc/xray/vlessnone.json
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target
EOF

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
mkdir /root/.acme.sh
curl https://acme-install.netlify.app/acme.sh -o /root/.acme.sh/acme.sh
chmod +x /root/.acme.sh/acme.sh
/root/.acme.sh/acme.sh --issue -d $domain --standalone -k ec-256
~/.acme.sh/acme.sh --installcert -d $domain --fullchainpath /etc/xray/xray.crt --keypath /etc/xray/xray.key --ecc
service squid start

service squid start
uuid=$(cat /proc/sys/kernel/random/uuid)
password="$(tr -dc 'a-z0-9A-Z' </dev/urandom | head -c 16)"
cat > /etc/xray/vmesstls.json <<END
{
  "log": {
    "access": "/var/log/xray/access.log",
    "error": "/var/log/xray/error.log",
    "loglevel": "info"
  },
  "inbounds": [
    {
      "port": 6363,
      "protocol": "vmess",
      "settings": {
        "clients": [
          {
            "id": "${uuid}"
#tls
          }
        ],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "tcp",
        "security": "tls",
        "tlsSettings": {
          "certificates": [
            {
              "certificateFile": "/etc/xray/xray.crt",
              "keyFile": "/etc/xray/xray.key"
            }
          ]
        },
        "tcpSettings": {
          "path": "/xray",
          "headers": {
            "Host": ""
          }
         },
        "quicSettings": {},
        "sockopt": {
          "mark": 0,
          "tcpFastOpen": true
        }
      },
      "sniffing": {
        "enabled": true,
        "destOverride": [
          "http",
          "tls"
        ]
      },
      "domain": "$domain"
    }
  ],
  "outbounds": [
    {
      "tag": "IP4_out",
      "protocol": "freedom",
      "settings": {}
    },
    {
      "tag": "IP6_out",
      "protocol": "freedom",
      "settings": {
        "domainStrategy": "UseIPv6"
      }
    },
    {
      "protocol": "blackhole",
      "settings": {},
      "tag": "blocked"
    }
  ],
  "routing": {
    "rules": [
      {
        "type": "field",
        "outboundTag": "IP6_out",
        "domain": [
          "geosite:netflix"
        ]
      },
      {
        "type": "field",
        "outboundTag": "IP4_out",
        "network": "udp,tcp"
      },
      {
        "type": "field",
        "ip": [
          "0.0.0.0/8",
          "10.0.0.0/8",
          "100.64.0.0/10",
          "169.254.0.0/16",
          "172.16.0.0/12",
          "192.0.0.0/24",
          "192.0.2.0/24",
          "192.168.0.0/16",
          "198.18.0.0/15",
          "198.51.100.0/24",
          "203.0.113.0/24",
          "::1/128",
          "fc00::/7",
          "fe80::/10"
        ],
        "outboundTag": "blocked"
      }
    ]
  }
}
END
cat > /etc/xray/vmessnone.json <<END
{
  "log": {
    "access": "/var/log/xray/access.log",
    "error": "/var/log/xray/error.log",
    "loglevel": "info"
  },
  "inbounds": [
    {
      "port": 6464,
      "protocol": "vmess",
      "settings": {
        "clients": [
          {
            "id": "${uuid}"
#none
          }
        ],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "tcp",
        "tcpSettings": {
          "path": "/xray",
          "headers": {
            "Host": ""
          }
         },
        "quicSettings": {},
        "sockopt": {
          "mark": 0,
          "tcpFastOpen": true
        }
      },
      "sniffing": {
        "enabled": true,
        "destOverride": [
          "http",
          "tls"
        ]
      },
      "domain": "$domain"
    }
  ],
  "outbounds": [
    {
      "tag": "IP4_out",
      "protocol": "freedom",
      "settings": {}
    },
    {
      "tag": "IP6_out",
      "protocol": "freedom",
      "settings": {
        "domainStrategy": "UseIPv6"
      }
    },
    {
      "protocol": "blackhole",
      "settings": {},
      "tag": "blocked"
    }
  ],
  "routing": {
    "rules": [
      {
        "type": "field",
        "outboundTag": "IP6_out",
        "domain": [
          "geosite:netflix"
        ]
      },
      {
        "type": "field",
        "outboundTag": "IP4_out",
        "network": "udp,tcp"
      },
      {
        "type": "field",
        "ip": [
          "0.0.0.0/8",
          "10.0.0.0/8",
          "100.64.0.0/10",
          "169.254.0.0/16",
          "172.16.0.0/12",
          "192.0.0.0/24",
          "192.0.2.0/24",
          "192.168.0.0/16",
          "198.18.0.0/15",
          "198.51.100.0/24",
          "203.0.113.0/24",
          "::1/128",
          "fc00::/7",
          "fe80::/10"
        ],
        "outboundTag": "blocked"
      }
    ]
  }
}
END
cat > /etc/xray/vlesstls.json <<END
{
  "log": {
    "access": "/var/log/xray/access2.log",
    "error": "/var/log/xray/error.log",
    "loglevel": "info"
  },
  "inbounds": [
    {
      "port": 6565,
      "protocol": "vless",
      "settings": {
        "clients": [
          {
            "id": "${uuid}"
#tls
          }
        ],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "tcp",
        "security": "tls",
        "tlsSettings": {
          "certificates": [
            {
              "certificateFile": "/etc/xray/xray.crt",
              "keyFile": "/etc/xray/xray.key"
            }
          ]
        },
        "tcpSettings": {
          "path": "/xray",
          "headers": {
            "Host": ""
          }
         },
        "quicSettings": {},
        "sockopt": {
          "mark": 0,
          "tcpFastOpen": true
        }
      },
      "sniffing": {
        "enabled": true,
        "destOverride": [
          "http",
          "tls"
        ]
      },
      "domain": "$domain"
    }
  ],
  "outbounds": [
    {
      "tag": "IP4_out",
      "protocol": "freedom",
      "settings": {}
    },
    {
      "tag": "IP6_out",
      "protocol": "freedom",
      "settings": {
        "domainStrategy": "UseIPv6"
      }
    },
    {
      "protocol": "blackhole",
      "settings": {},
      "tag": "blocked"
    }
  ],
  "routing": {
    "rules": [
      {
        "type": "field",
        "outboundTag": "IP6_out",
        "domain": [
          "geosite:netflix"
        ]
      },
      {
        "type": "field",
        "outboundTag": "IP4_out",
        "network": "udp,tcp"
      },
      {
        "type": "field",
        "ip": [
          "0.0.0.0/8",
          "10.0.0.0/8",
          "100.64.0.0/10",
          "169.254.0.0/16",
          "172.16.0.0/12",
          "192.0.0.0/24",
          "192.0.2.0/24",
          "192.168.0.0/16",
          "198.18.0.0/15",
          "198.51.100.0/24",
          "203.0.113.0/24",
          "::1/128",
          "fc00::/7",
          "fe80::/10"
        ],
        "outboundTag": "blocked"
      }
    ]
  }
}
END
cat > /etc/xray/vlessnone.json <<END
{
  "log": {
    "access": "/var/log/xray/access2.log",
    "error": "/var/log/xray/error.log",
    "loglevel": "info"
  },
  "inbounds": [
    {
      "port": 6666,
      "protocol": "vless",
      "settings": {
        "clients": [
          {
            "id": "${uuid}"
#none
          }
        ],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "tcp",
        "tcpSettings": {
          "path": "/xray",
          "headers": {
            "Host": ""
          }
         },
        "quicSettings": {},
        "sockopt": {
          "mark": 0,
          "tcpFastOpen": true
        }
      },
      "sniffing": {
        "enabled": true,
        "destOverride": [
          "http",
          "tls"
        ]
      },
      "domain": "$domain"
    }
  ],
  "outbounds": [
    {
      "tag": "IP4_out",
      "protocol": "freedom",
      "settings": {}
    },
    {
      "tag": "IP6_out",
      "protocol": "freedom",
      "settings": {
        "domainStrategy": "UseIPv6"
      }
    },
    {
      "protocol": "blackhole",
      "settings": {},
      "tag": "blocked"
    }
  ],
  "routing": {
    "rules": [
      {
        "type": "field",
        "outboundTag": "IP6_out",
        "domain": [
          "geosite:netflix"
        ]
      },
      {
        "type": "field",
        "outboundTag": "IP4_out",
        "network": "udp,tcp"
      },
      {
        "type": "field",
        "ip": [
          "0.0.0.0/8",
          "10.0.0.0/8",
          "100.64.0.0/10",
          "169.254.0.0/16",
          "172.16.0.0/12",
          "192.0.0.0/24",
          "192.0.2.0/24",
          "192.168.0.0/16",
          "198.18.0.0/15",
          "198.51.100.0/24",
          "203.0.113.0/24",
          "::1/128",
          "fc00::/7",
          "fe80::/10"
        ],
        "outboundTag": "blocked"
      }
    ]
  }
}
END
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

cat > /etc/xray/trojan.json <<END
{
    "log": {
        "loglevel": "warning"
    },
    "inbounds": [
        {
            "port": 2096,
            "protocol": "trojan",
            "settings": {
                "clients": [
                    {
                        "password":"dev",
                        "email": ""
#xray-trojan
                    }
                ]
            },
            "streamSettings": {
                "network": "tcp",
                "security": "tls",
                "tlsSettings": {
                    "alpn": [
                        "http/1.1"
                    ],
                    "certificates": [
                        {
                            "certificateFile": "/etc/xray/xray.crt",
                            "keyFile": "/etc/xray/xray.key"
                        }
                    ]
                }
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

cat > /etc/xray/vmessgrpc.json << END
{
    "log": {
            "access": "/var/log/xray/access5.log",
        "error": "/var/log/xray/error.log",
        "loglevel": "info"
    },
    "inbounds": [
        {
            "port": 8000,
            "protocol": "vmess",
            "settings": {
                "clients": [
                    {
                        "id": "${uuid}"
#vmessgrpc
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

cat > /etc/systemd/system/vmess-grpc.service << EOF
[Unit]
Description=XRay VMess GRPC Service
Documentation=https://speedtest.net https://github.com/XTLS/Xray-core
After=network.target nss-lookup.target

[Service]
User=root
NoNewPrivileges=true
ExecStart=/usr/local/xray/xray -config /etc/xray/vmessgrpc.json
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target
EOF

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

iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 6363 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 6363 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 6464 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 6464 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 6565 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 6565 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 6666 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 6666 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 88 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 88 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 8000 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 8000 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 880 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 880 -j ACCEPT
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save
netfilter-persistent reload
systemctl daemon-reload
systemctl enable xr-vm-tls.service
systemctl start xr-vm-tls.service
systemctl enable xr-vm-ntls.service
systemctl start xr-vm-ntls.service
systemctl enable xr-vl-tls.service
systemctl start xr-vl-tls.service
systemctl enable xr-vl-ntls.service
systemctl start xr-vl-ntls.service
systemctl enable xtls.service
systemctl start xtls.service
systemctl enable vmess-grpc.service
systemctl start vmess-grpc.service
systemctl enable vless-grpc.service
systemctl start vless-grpc.service

cd /usr/bin

wget -O pv2ray "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/pv2ray.sh"
wget -O pxray "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/pxray.sh"
wget -O mxtls "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/mxtls.sh"
wget -O mxvmess "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/mxvmess.sh"
wget -O mxvless "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/mxvless.sh"
wget -O mgrpc "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/mgrpc.sh"
wget -O add-xtls "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/add-xtls.sh"
wget -O add-xvmess "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/add-xvmess.sh"
wget -O add-xvless "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/add-xvless.sh"
wget -O add-grpc "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/add-grpc.sh"
wget -O del-xtls "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/del-xtls.sh"
wget -O del-xvmess "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/del-xvmess.sh"
wget -O del-xvless "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/del-xvless.sh"
wget -O del-xgrpc "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/del-grpc.sh"
wget -O cek-xtls "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/cek-xtls.sh"
wget -O cek-xvmess "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/cek-xvmess.sh"
wget -O cek-xvless "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/cek-xvless.sh"
wget -O cek-grpc "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/cek-grpc.sh"
wget -O renew-xtls "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/renew-xtls.sh"
wget -O renew-xvmess "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/renew-xvmess.sh"
wget -O renew-xvless "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/renew-xvless.sh"
wget -O renew-xtrgo "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/renew-xtrgo.sh"
wget -O renew-grpc "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/renew-grpc.sh"
wget -O port-xtls "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/port-xtls.sh"
wget -O port-xvmess "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/port-xvmess.sh"
wget -O port-xvless "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/port-xvless.sh"
wget -O port-grpc "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/XRAY/port-grpc.sh"
chmod +x pv2ray
chmod +x pxray
chmod +x mxtls
chmod +x mxvmess
chmod +x mxvless
chmod +x mgrpc
chmod +x add-xtls
chmod +x add-xvmess
chmod +x add-xvless
chmod +x add-grpc
chmod +x del-xtls
chmod +x del-xvmess
chmod +x del-xvless
chmod +x del-xgrpc
chmod +x cek-xtls
chmod +x cek-xvmess
chmod +x cek-xvless
chmod +x cek-grpc
chmod +x renew-xtls
chmod +x renew-xvmess
chmod +x renew-xvless
chmod +x renew-grpc
chmod +x port-xtls
chmod +x port-xvmess
chmod +x port-xvless
chmod +x port-grpc
cd
rm -f install-xray.sh

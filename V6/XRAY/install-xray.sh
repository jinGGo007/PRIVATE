#!/bin/bash
# V2Ray Mini Core Version 4.42.2
domain=$(cat /etc/v2ray/domain)

apt update -y
apt upgrade -y
apt install socat -y
apt install python -y
apt install sed -y
apt install nano -y
apt install python3 -y
apt install iptables iptables-persistent -y
apt install curl socat xz-utils wget apt-transport-https gnupg gnupg2 gnupg1 dnsutils lsb-release -y
apt install socat cron bash-completion ntpdate -y
ntpdate pool.ntp.org
apt -y install chrony
timedatectl set-ntp true
systemctl enable chronyd && systemctl restart chronyd
systemctl enable chrony && systemctl restart chrony
timedatectl set-timezone Asia/Kuala_Lumpur
chronyc sourcestats -v
chronyc tracking -v
date


# / / Ambil Xray Core Version Terbaru
latest_version="$(curl -s https://api.github.com/repos/XTLS/Xray-core/releases | grep tag_name | sed -E 's/.*"v(.*)".*/\1/' | head -n 1)"

# / / Installation Xray Core
xraycore_link="https://github.com/XTLS/Xray-core/releases/download/v$latest_version/xray-linux-64.zip"

# / / Make Main Directory
mkdir -p /usr/bin/xray
mkdir -p /etc/xray

# / / Unzip Xray Linux 64
cd `mktemp -d`
curl -sL "$xraycore_link" -o xray.zip
unzip -q xray.zip && rm -rf xray.zip
mv xray /usr/local/bin/xray
chmod +x /usr/local/bin/xray

# Make Folder XRay
mkdir -p /var/log/xray/
touch /etc/xray/xray.pid

uuid=$(cat /proc/sys/kernel/random/uuid)

# Buat Config Xray TLS
cat > /etc/xray/v2ray-tls.json << END
{
  "log": {
    "access": "/var/log/xray/v2ray-login.log",
    "error": "/var/log/xray/v2ray-error.log",
    "loglevel": "info"
  },
  "inbounds": [
    {
      "port": 2929,
      "protocol": "vmess",
      "settings": {
        "clients": [
          {
            "id": "${uuid}",
            "alterId": 0
#xray-v2ray-tls
          }
        ]
      },
      "streamSettings": {
        "network": "ws",
        "security": "tls",
        "tlsSettings": {
          "certificates": [
            {
              "certificateFile": "/etc/xray/xray.crt",
              "keyFile": "/etc/xray/xray.key"
            }
          ]
        },
        "wsSettings": {
          "path": "/xvmess",
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
      "protocol": "freedom",
      "settings": {}
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
      },
      {
        "type": "field",
        "outboundTag": "blocked",
        "protocol": [
          "bittorrent"
        ]
      }
    ]
  }
}
END
cat > /etc/xray/v2ray-nontls.json << END
{
  "log": {
    "access": "/var/log/xray/v2ray-login.log",
    "error": "/var/log/xray/v2ray-error.log",
    "loglevel": "info"
  },
  "inbounds": [
    {
      "port": 3939,
      "protocol": "vmess",
      "settings": {
        "clients": [
          {
            "id": "${uuid}",
            "alterId": 0
#xray-v2ray-nontls
          }
        ]
      },
      "streamSettings": {
        "network": "ws",
        "wsSettings": {
          "path": "/xvmess",
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
      "protocol": "freedom",
      "settings": {}
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
      },
      {
        "type": "field",
        "outboundTag": "blocked",
        "protocol": [
          "bittorrent"
        ]
      }
    ]
  }
}
END
cat > /etc/xray/vless-tls.json << END
{
  "log": {
    "access": "/var/log/xray/vless-login.log",
    "error": "/var/log/xray/vless-error.log",
    "loglevel": "info"
  },
  "inbounds": [
    {
      "port": 4949,
      "protocol": "vless",
      "settings": {
        "clients": [
          {
            "id": "${uuid}"
#xray-vless-tls
          }
        ],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "ws",
        "security": "tls",
        "tlsSettings": {
          "certificates": [
            {
              "certificateFile": "/etc/xray/xray.crt",
              "keyFile": "/etc/xray/xray.key"
            }
          ]
        },
        "wsSettings": {
          "path": "/xvless",
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
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom",
      "settings": {}
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
      },
      {
        "type": "field",
        "outboundTag": "blocked",
        "protocol": [
          "bittorrent"
        ]
      }
    ]
  }
}
END
cat > /etc/xray/vless-nontls.json << END
{
  "log": {
    "access": "/var/log/xray/vless-login.log",
    "error": "/var/log/xray/vless-error.log",
    "loglevel": "info"
  },
  "inbounds": [
    {
      "port": 5959,
      "protocol": "vless",
      "settings": {
        "clients": [
          {
            "id": "${uuid}"
#xray-vless-nontls
          }
        ],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "ws",
        "wsSettings": {
          "path": "/xvless",
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
      "protocol": "freedom",
      "settings": {}
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
      },
      {
        "type": "field",
        "outboundTag": "blocked",
        "protocol": [
          "bittorrent"
        ]
      }
    ]
  }
}
END

cat > /etc/xray/vmess-grpc.json << END
{
    "log": {
            "access": "/var/log/xray/vmess-grpc-login.log",
        "error": "/var/log/xray/vmess-grpc-error.log",
        "loglevel": "info"
    },
    "inbounds": [
        {
            "port": 7979,
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
                "network": "grpc",
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

cat > /etc/xray/vless-grpc.json << END
{
    "log": {
            "access": "/var/log/xray/vless-grpc.log",
        "error": "/var/log/xray/vless-grpc-error.log",
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
                "network": "grpc",
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

cat > /etc/xray/trojan-grpc.json << END
{
  "log": {
    "access": "/var/log/xray/trojan-grpc.log",
    "error": "/var/log/xray/trojan-grpc-error.log",
    "loglevel": "warning"
  },
  "inbounds": [
    {
      "port": 8989,
      "protocol": "trojan",
      "settings": {
        "clients": [
          {
            "password": "${uuid}"
#xray-trojan-grpc
            }
          ]
        },
        "decryption": "none"
      },
      "streamSettings": {
        "network": "grpc",
        "grpcSettings": {
          "serviceName": "trojangrpc"
            }
          }
        }
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom",
      "tag": "direct"
    },
    {
      "protocol": "blackhole",
      "tag": "blocked"
      }
  ],
  "dns": {
    "servers": [
      "8.8.8.8",
      "8.8.4.4",
      "1.1.1.1",
      "1.0.0.1",
      "localhost",
      "https+local://dns.google/dns-query",
      "https+local://1.1.1.1/dns-query"
    ]
  },
  "routing": {
    "domainStrategy": "AsIs",
    "rules": [
      {
        "type": "field",
        "inboundTag": [
          "trojan-grpc-in",
        ],
        "outboundTag": "direct"
      }
    ]
  }
}
END

# config Vless Direct
cat > /etc/xray/vless-direct.json << END
{
    "log": {
    "access": "/var/log/xray/vless-direct-login.log",
    "error": "/var/log/xray/error.log",
    "loglevel": "info"
  },
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
cat > /etc/xray/xtrojan.json <<END
{
    "log": {
        "loglevel": "warning"
    },
    "inbounds": [
        {
            "port": 9999,
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

# / / Installation V2Ray Service
cat > /etc/systemd/system/xray@.service << END
[Unit]
Description=Xray Service ( %i ) By JINGGO007
Documentation=https://raw.githubusercontent.com/jinGGo007/main/
After=network.target nss-lookup.target

[Service]
Type=simple
StandardError=journal
PIDFile=/etc/xray/xray.pid
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/xray -config /etc/xray/%i.json
ExecStop=/usr/local/bin/xray
LimitNOFILE=65535
Restart=on-failure
RestartSec=1s

[Install]
WantedBy=multi-user.target
END


# // Enable & Start Service
# Accept port Xray
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 2929 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 2929 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 3939 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 3939 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 4949 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 4949 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 5959 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 5959 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 6969 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 6969 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 7979 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 7979 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 8989 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 8989 -j ACCEPT
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save
netfilter-persistent reload
systemctl daemon-reload
systemctl stop xray@v2ray-tls
systemctl stop xray@v2ray-nontls
systemctl stop xray@vless-tls
systemctl stop xray@vless-nontls
systemctl stop xray@vmess-grpc
systemctl stop xray@vless-grpc
systemctl stop xray@trojan-grpc
systemctl stop xray@vless-direct
systemctl start xray@v2ray-tls 
systemctl start xray@v2ray-nontls 
systemctl start xray@vless-tls 
systemctl start xray@vless-nontls 
systemctl start xray@vmess-grpc
systemctl start xray@vless-grpc
systemctl start xray@trojan-grpc 
systemctl start xray@vless-direct
systemctl enable xray@v2ray-tls
systemctl enable xray@v2ray-nontls
systemctl enable xray@vless-tls
systemctl enable xray@vless-nontls
systemctl enable xray@vmess-grpc
systemctl enable xray@vless-grpc
systemctl enable xray@trojan-grpc
systemctl enable xray@vless-direct
systemctl restart xray@v2ray-tls
systemctl restart xray@v2ray-nontls
systemctl restart xray@vless-tls
systemctl restart xray@vless-nontls
systemctl restart xray@vmess-grpc
systemctl restart xray@vless-grpc
systemctl restart xray@trojan-grpc
systemctl restart xray@vless-direct


mkdir /root/.acme.sh
curl https://acme-install.netlify.app/acme.sh -o /root/.acme.sh/acme.sh
chmod +x /root/.acme.sh/acme.sh
/root/.acme.sh/acme.sh --set-default-ca --server letsencrypt
~/.acme.sh/acme.sh --issue -d $domain --standalone -k ec-256
~/.acme.sh/acme.sh --installcert -d $domain --fullchainpath /etc/xray/xray.crt --keypath /etc/xray/xray.key --ecc
service squid start

cd /usr/bin
wget -O mxvmess "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/V6/XRAY/mxvmess.sh"
wget -O add-xvmess "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/V6/XRAY/add-xvmess.sh"
wget -O del-xvmess "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/V6/XRAY/del-xvmess.sh"
wget -O renew-xvmess "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/V6/XRAY/renew-xvmess.sh"
wget -O cek-xvmess "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/V6/XRAY/cek-xvmess.sh"
wget -O port-xvmess "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/V6/XRAY/port-xvmess.sh"
wget -O mxvless "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/V6/XRAY/mxvless.sh"
wget -O add-xvless "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/V6/XRAY/add-xvless.sh"
wget -O del-xvless "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/V6/XRAY/del-xvless.sh"
wget -O renew-xvless "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/V6/XRAY/renew-xvless.sh"
wget -O cek-xvless "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/V6/XRAY/cek-xvless.sh"
wget -O port-xvless "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/V6/XRAY/port-xvless.sh"
wget -O mgrpc "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/V6/XRAY/mgrpc.sh"
wget -O add-grpc "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/V6/XRAY/add-grpc.sh"
wget -O del-grpc "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/V6/XRAY/del-grpc.sh"
wget -O renew-grpc "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/V6/XRAY/renew-grpc.sh"
wget -O cek-grpc "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/V6/XRAY/cek-grpc.sh"
wget -O port-grpc "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/V6/XRAY/port-grpc.sh"
wget -O mxtls "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/V6/XRAY/mxtls.sh"
wget -O add-xtls "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/V6/XRAY/add-xtls.sh"
wget -O del-xtls "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/V6/XRAY/del-xtls.sh"
wget -O renew-xtls "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/V6/XRAY/renew-xtls.sh"
wget -O cek-xtls "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/V6/XRAY/cek-xtls.sh"
wget -O port-xtls "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/V6/XRAY/port-xtls.sh"
wget -O recert-xray "https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/V6/XRAY/recert-xray.sh"
chmod +x mxvmess
chmod +x add-xvmess
chmod +x del-xvmess
chmod +x renew-xvmess
chmod +x cek-xvmess
chmod +x port-xvmess
chmod +x mxvless
chmod +x add-xvless
chmod +x del-xvless
chmod +x renew-xvless
chmod +x cek-xvless
chmod +x port-xvless
chmod +x mgrpc
chmod +x add-grpc
chmod +x del-grpc
chmod +x renew-grpc
chmod +x cek-grpc
chmod +x port-grpc
chmod +x mxtls
chmod +x add-xtls
chmod +x del-xtls
chmod +x renew-xtls
chmod +x cek-xtls
chmod +x port-xtls
chmod +x recert-xray
rm -f install-xray.sh
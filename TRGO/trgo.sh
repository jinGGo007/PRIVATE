#!/bin/bash
# Trojan Go Auto Setup 
# =========================

# Domain 
domain=$(cat /etc/v2ray/domain)

# Uuid Service
uuid=$(cat /proc/sys/kernel/random/uuid)

# Trojan Go Akun 
mkdir -p /etc/trojan-go/
touch /etc/trojan-go/akun.conf
touch /etc/trojan-go/uuid.txt

# Installing Trojan Go
mkdir -p /etc/trojan-go/
chmod 777 /etc/trojan-go/
touch /etc/trojan-go/trojan-go.pid
wget -O /etc/trojan-go/trojan-go https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/TRGO/trojan-go
chmod +x /etc/trojan-go/trojan-go
cat <<EOF > /etc/trojan-go/config.json
{
    "run_type": "server",
    "local_addr": "0.0.0.0",
    "local_port": 7979,
    "remote_addr": "127.0.0.1",
    "remote_port": 81,
    "log_level": 1,
    "log_file": "",
    "password": [
        "$uuid"
    ],
  "disable_http_check": false,
  "udp_timeout": 60,
  "ssl": {
    "verify": true,
    "verify_hostname": true,
    "cert": "/etc/xray/xray.crt",
    "key": "etc/xray/xray.key",
    "key_password": "",
    "cipher": "",
    "curves": "",
    "prefer_server_cipher": false,
    "sni": "$domain",
    "alpn": [
      "http/1.1"
    ],
    "session_ticket": true,
    "reuse_session": true,
    "plain_http_response": "",
    "fallback_addr": "127.0.0.1",
    "fallback_port": 7979,
    "fingerprint": ""
  },
  "tcp": {
    "no_delay": true,
    "keep_alive": true,
    "prefer_ipv4": false
  },
  "websocket": {
    "enabled": true,
    "path": "/trgo",
    "host": "$domain"
  }
}
EOF
cat <<EOF > /etc/systemd/system/trojan-go.service
[Unit]
Description=Trojan-Go  By JINGGO007
Documentation=https://t.me/jinggo007
After=network.target nss-lookup.target
[Service]
User=root
NoNewPrivileges=true
ExecStart=/etc/trojan-go/trojan-go -config /etc/trojan-go/config.json
Restart=on-failure
RestartSec=10s
LimitNOFILE=infinity
[Install]
WantedBy=multi-user.target
EOF

cat <<EOF > /etc/trojan-go/uuid.txt
$uuid
EOF
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 7979 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 7979 -j ACCEPT
iptables-save >/etc/iptables.rules.v4
netfilter-persistent save
netfilter-persistent reload
systemctl daemon-reload

# Starting
systemctl daemon-reload
systemctl enable trojan-go.service
systemctl start trojan-go.service
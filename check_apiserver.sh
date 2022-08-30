cat >> /etc/keepalived/check_apiserver.sh <<EOF
#!/bin/sh

errorExit() {
  echo "*** $@" 1>&2
  exit 1
}

curl --silent --max-time 2 --insecure https://localhost:6443/ -o /dev/null || errorExit "Error GET https://localhost:6443/"
if ip addr | grep -q 192.168.180.25; then
  curl --silent --max-time 2 --insecure https://192.168.180.25:6443/ -o /dev/null || errorExit "Error GET https://192.168.180.25:6443/"
fi
EOF

chmod +x /etc/keepalived/check_apiserver.sh

#192.168.180.25 Virtual IP

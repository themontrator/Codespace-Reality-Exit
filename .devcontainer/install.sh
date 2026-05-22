#!/bin/bash
echo "=== Codespace Reality Exit Node - Installer ==="

apt update && apt install -y curl unzip tmux openssl

# نصب Sing-box
bash <(curl -fsSL https://sing-box.sagernet.org/install.sh)

# تولید کلیدها
sing-box generate reality-keypair > reality_keys.txt
UUID=$(sing-box generate uuid)
SHORT_ID=$(openssl rand -hex 8)
PRIVATE_KEY=$(grep "PrivateKey" reality_keys.txt | awk '{print $2}')
PUBLIC_KEY=$(grep "PublicKey" reality_keys.txt | awk '{print $2}')

# ساخت کانفیگ سرور
cat > config.json << EOC
{
  "log": { "level": "info" },
  "inbounds": [
    {
      "type": "vless",
      "listen": "::",
      "listen_port": 443,
      "users": [{ "uuid": "$UUID" }],
      "tls": {
        "enabled": true,
        "server_name": "www.microsoft.com",
        "reality": {
          "enabled": true,
          "private_key": "$PRIVATE_KEY",
          "short_id": ["$SHORT_ID"],
          "handshake": {
            "server": "www.microsoft.com",
            "server_port": 443
          }
        }
      }
    }
  ],
  "outbounds": [{ "type": "direct" }]
}
EOC

echo "============================================"
echo "✅ نصب با موفقیت انجام شد!"
echo "UUID        : $UUID"
echo "Public Key  : $PUBLIC_KEY"
echo "Short ID    : $SHORT_ID"
echo "============================================"
echo "برای اجرا: ./start.sh"

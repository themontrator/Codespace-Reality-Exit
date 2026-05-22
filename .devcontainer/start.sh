#!/bin/bash
tmux kill-session -t singbox 2>/dev/null || true
tmux new-session -d -s singbox 'sing-box run -c config.json'
echo "✅ Sing-box VLESS-Reality فعال شد (پورت 443)"
echo "برای دیدن لاگ: tmux attach -t singbox"

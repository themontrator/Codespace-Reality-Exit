FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Asia/Tehran

WORKDIR /app

# کپی فایل‌های پروژه
COPY install.sh /app/install.sh
COPY start.sh /app/start.sh

# نصب وابستگی‌ها با خروجی مرتب
RUN echo "📦 Installing system dependencies..." && \
    apt-get update && apt-get install -y --no-install-recommends \
    curl unzip tmux openssl ca-certificates git sudo \
    && echo "✅ Dependencies installed successfully" && \
    rm -rf /var/lib/apt/lists/*

# نصب Sing-box
RUN echo "⚙️ Installing Sing-box..." && \
    bash <(curl -fsSL https://sing-box.sagernet.org/install.sh) && \
    echo "✅ Sing-box installed successfully"

# دادن مجوز اجرا
RUN chmod +x /app/install.sh /app/start.sh

# ایجاد startup.sh با بنر حرفه‌ای
RUN echo '#!/bin/bash' > /app/startup.sh && \
    echo 'echo ""' >> /app/startup.sh && \
    echo 'echo "╔════════════════════════════════════════════════════════════╗"' >> /app/startup.sh && \
    echo 'echo "║           🚀  Codespace Reality Exit Node  🚀             ║"' >> /app/startup.sh && \
    echo 'echo "╚════════════════════════════════════════════════════════════╝"' >> /app/startup.sh && \
    echo 'echo ""' >> /app/startup.sh && \
    echo 'echo "📋 Status: Sing-box + VLESS-Reality is running"' >> /app/startup.sh && \
    echo 'echo "🔌 Port: 443"' >> /app/startup.sh && \
    echo 'echo ""' >> /app/startup.sh && \
    echo 'echo "📌 For logs: tmux attach -t singbox"' >> /app/startup.sh && \
    echo 'echo ""' >> /app/startup.sh && \
    echo 'exec tmux new-session -d -s singbox "sing-box run -c /app/config.json" && tail -f /dev/null' >> /app/startup.sh && \
    chmod +x /app/startup.sh

EXPOSE 443

CMD ["/app/startup.sh"]

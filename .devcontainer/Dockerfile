FROM mcr.microsoft.com/devcontainers/base:ubuntu

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Tehran

# نصب ابزارهای مورد نیاز
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    tmux \
    openssl \
    ca-certificates \
    git \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# نصب آخرین نسخه Sing-box
RUN bash -c "$(curl -fsSL https://sing-box.sagernet.org/install.sh)"

USER root

WORKDIR /workspaces/Codespace-Reality-Exit

# کپی فایل‌های اصلی پروژه از ریشه به داخل کانتینر
COPY install.sh start.sh ./
COPY reality_keys.txt config.json . 2>/dev/null || true

RUN chmod +x install.sh start.sh

EXPOSE 443

CMD ["bash", "install.sh"]

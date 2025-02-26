#!/bin/bash

# 檢查是否為 root 權限
if [ "$EUID" -ne 0 ]; then
  echo "請使用 sudo 或以 root 身份執行此腳本"
  exit 1
fi

# 系統更新與升級
echo "正在更新系統..."
apt update && apt upgrade -y
if [ $? -ne 0 ]; then
  echo "系統更新失敗，請檢查網絡連接"
  exit 1
fi

# 防火墻配置
echo "配置防火墻..."
ufw allow 22/tcp
ufw --force enable  # 強制啟用避免交互提示
echo "已允許 SSH 端口並啟用 UFW"

# 啟用 BBR 擁塞控制
echo "啟用 BBR..."
sed -i '/net.core.default_qdisc/d' /etc/sysctl.conf
sed -i '/net.ipv4.tcp_congestion_control/d' /etc/sysctl.conf
echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
sysctl -p >/dev/null
echo "BBR 已啟用"

# 時區設置
echo "設置時區為上海..."
timedatectl set-timezone Asia/Shanghai

# 修改 gai.conf 優先 IPv4
echo "調整網絡優先級..."
sed -i 's/#precedence ::ffff:0:0\/96  100/precedence ::ffff:0:0\/96  100/' /etc/gai.conf
systemctl restart systemd-resolved

# 安裝工具
echo "安裝常用工具..."
apt install -y nala fish eza
if [ $? -ne 0 ]; then
  echo "軟件安裝失敗"
  exit 1
fi

# 修改默認 shell 為 fish
echo "設置 Fish 為默認 Shell..."
chsh -s /usr/bin/fish "$SUDO_USER"  # 保留原用戶身份
echo "Fish Shell 已設置"

# 完成提示
echo -e "\n\033[32m初始化完成！建議立即重啟系統\033[0m"
echo "可執行以下命令重啟：sudo reboot"

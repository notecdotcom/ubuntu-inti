#!/bin/bash

# root権限チェック
if [ "$EUID" -ne 0 ]; then
  echo "sudo または root ユーザーで実行してください"
  exit 1
fi

# システムの更新とアップグレード
echo "システムを更新中..."
apt update && apt upgrade -y
if [ $? -ne 0 ]; then
  echo "システム更新失敗 - ネットワーク接続を確認してください"
  exit 1
fi

# ファイアウォール設定
echo "ファイアウォールを設定中..."
ufw allow 22/tcp
ufw --force enable  # 対話プロンプトを回避
echo "SSHポート(22/tcp)を許可しUFWを有効化"

# BBR輻輳制御の有効化
echo "BBRを有効化中..."
sed -i '/net.core.default_qdisc/d' /etc/sysctl.conf
sed -i '/net.ipv4.tcp_congestion_control/d' /etc/sysctl.conf
echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
sysctl -p >/dev/null
echo "BBRが正常に有効化されました"

# タイムゾーン設定
echo "タイムゾーンを東京に設定..."
timedatectl set-timezone Asia/Tokyo

# IPv4優先設定
echo "ネットワーク優先度を調整中..."
sed -i 's/#precedence ::ffff:0:0\/96  100/precedence ::ffff:0:0\/96  100/' /etc/gai.conf
systemctl restart systemd-resolved

# パッケージインストール
echo "ツールをインストール中..."
apt install -y nala fish eza
if [ $? -ne 0 ]; then
  echo "パッケージインストール失敗"
  exit 1
fi

# デフォルトシェルの変更
echo "デフォルトシェルをFishに設定..."
chsh -s /usr/bin/fish "$SUDO_USER"  # 元ユーザー権限を保持
echo "Fishシェルが設定されました"

# 完了メッセージ
echo -e "\n\033[32m初期化完了！システムの再起動を推奨します\033[0m"
echo "再起動コマンド: sudo reboot"

# Ubuntu サーバー初期化スクリプト

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
![動作確認環境](https://img.shields.io/badge/Tested_on-Ubuntu_24.04_LTS-green)

Ubuntu サーバーの基本的な設定を自動化する Bash スクリプト。開発/本番環境の迅速な構築に適しています。

## 🚀 主な機能

- **システム最適化**
  - 自動更新＆アップグレード
  - BBR 輻輳制御の有効化
  - IPv4 接続優先設定
  - タイムゾーン `Asia/Tokyo` 設定

- **セキュリティ設定**
  - UFW ファイアウォールの有効化（SSH 22ポート開放）
  - root 権限の自動検証

- **ツールセットアップ**
  - 高速パッケージマネージャ `nala` の導入
  - モダンな Shell 環境構築（`Fish` + `eza`）

## 📥 インストール＆使用方法

### クイックスタート
```bash
# ワンクリック
wget -O ubuntu_init.sh https://raw.githubusercontent.com/yourusername/your-repo/main/ubuntu_init.sh && chmod +x ubuntu_init.sh && sudo ./ubuntu_init.sh

# Ubuntu Server 初始化腳本

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
![Compatibility](https://img.shields.io/badge/Tested_on-Ubuntu_22.04_LTS-green)

一個自動化初始化 Ubuntu 服務器的 Bash 腳本，用於快速部署開發/生產環境。

## 🚀 功能特性

- **系統優化**
  - 自動更新與升級
  - 啟用 BBR 網絡加速
  - 優先 IPv4 連接
  - 時區設置為 `Asia/Shanghai`

- **安全配置**
  - 啟用 UFW 防火墻並開放 SSH 端口
  - 內置 Root 權限檢查

- **工具安裝**
  - 安裝高效包管理器 `nala`
  - 配置現代化 Shell 環境 (`Fish` + `eza`)

## 📥 安裝與使用

### 快速開始
```bash
wget -O ubuntu_init.sh https://raw.githubusercontent.com/notecdotcom/ubuntu-inti/main/ubuntu_init.sh && chmod +x ubuntu_init.sh && sudo ./ubuntu_init.sh

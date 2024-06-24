#LetsEncryptのSSL更新をAliasコマンド叩いて実行できるようにする
# ディレクトリとスクリプトの作成
mkdir -p /home/asp_ssl_update/
touch /home/asp_ssl_update/update_ssl.sh
chmod +x /home/asp_ssl_update/update_ssl.sh

# スクリプトの内容を記述
cat << 'EOF' > /home/asp_ssl_update/update_ssl.sh
#!/bin/bash

# SSL証明書ディレクトリ名のリストを取得
cert_names=$(ls -d /etc/letsencrypt/live/*/ | grep -oP '[^/]+(?=/$)')

# 置換してコマンドを実行する
for cert_name in $cert_names; do
  if [[ $cert_name != "README" && $cert_name != "." && $cert_name != ".." ]]; then
    /usr/local/src/certbot/certbot-auto renew --force-renewal --cert-name "$cert_name"
    sleep 120
  fi
done
EOF

# Aliasの作成
echo "alias updatessl='/home/asp_ssl_update/update_ssl.sh'" >> ~/.bashrc

# .bashrcを再読み込み
source ~/.bashrc

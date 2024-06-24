#LetsEncryptのSSL更新をAliasコマンド叩いて実行できるようにする
# ディレクトリとスクリプトの作成
mkdir -p /home/asp_ssl_update/
touch /home/asp_ssl_update/update_ssl.sh
chmod +x /home/asp_ssl_update/update_ssl.sh

# スクリプトの内容を記述
cat << 'EOF' > /home/asp_ssl_update/update_ssl.sh
#!/bin/bash

# SSL証明書名のリストを取得してファイルに保存
ls -la -rt /etc/letsencrypt/live/ > /home/asp_ssl_update/cert_names.txt

# 置換してコマンドを実行する
while read -r line; do
  cert_name=$(echo "$line" | grep -oP '([0-9a-z].+)')
  if [[ -n "$cert_name" ]]; then
    /usr/local/src/certbot/certbot-auto renew --force-renewal --cert-name "$cert_name"
    sleep 120
  fi
done < /home/asp_ssl_update/cert_names.txt
EOF

# Aliasの作成
echo "alias updatessl='/home/asp_ssl_update/update_ssl.sh'" >> ~/.bashrc

# .bashrcを再読み込み
source ~/.bashrc

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

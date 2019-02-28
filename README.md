# Prometheus Alertmanager のテスト用 docker-compose

## 起動方法

```
docker-compose up
```

http://$(docker-machine ip):9093/ で Alertmanager の Web UI に、 http://$(docker-machine ip):8025/ で Mailhog にアクセスできる (Basic 認証は `user` / `password`)。docker-machine でない場合は適宜読みかえ。

webhook はログで確認

```
docker-compose exec alertmanager amtool --alertmanager.url http://localhost:9093/ alert
```

などとして amtool でアクセス可能

## メモ

### MailHog のSMTP Auth 用パスワード生成

alertmanager の SMTP クライアントは認証設定しないとメールを送ってくれない
(EHLO のレスポンスを受けた後にすぐ QUIT を送る) ようなので
Mailhog に SMTP AUTH 対応させる

password ファイルには bcrypt で生成する hash を書く必要があり、hash 値は次のようにして計算できる

```
docker run --rm -it mailhog/mailhog:v1.0.0 bcrypt password-string
```

### Ghostunnel で SMTP over SSL 対応

Go の SMTP クライアントが SMTP AUTH で PLAIN Method を使う場合には
通信の暗号化を必須とするため Ghostunnel で SMTP over SSL にする

alertmanager の SMTP クライアントは port が 465 の場合にのみ SSL/TLS での
接続をこころみるため、Ghostunnel コンテナが expose するポートは 465 にする必要がある

### Ghostunnel で使うサーバー証明書の作成

PKCS12 フォーマットにする必要がある

```
bash mkcert.sh
```

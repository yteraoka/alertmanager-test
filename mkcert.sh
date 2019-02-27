cn=ssmtp
dir=ssmtp

dd if=/dev/urandom of=random bs=1K count=1

cat <<EOF | openssl req \
  -x509 \
  -days 365 \
  -newkey rsa:2048 \
  -rand random \
  -nodes \
  -keyout ${dir}/${cn}.key.pem \
  -out ${dir}/${cn}.crt.pem
JP
Tokyo
Minato-ku
Example, Inc.

${cn}
user@example.com


EOF

echo

# Windows の git-bash でこれをやると最初の "/" が "C:\Program Files\Git" に変わってしまう
#  -subj "/C=JP/ST=Tokyo/L=Chuo-ku/O=Example Inc./CN=${cn}/email=user@example.com"

rm -f random

openssl pkcs12 \
  -export \
  -inkey ${dir}/${cn}.key.pem \
  -in ${dir}/${cn}.crt.pem \
  -out ${dir}/${cn}.pfx \
  -passout pass:

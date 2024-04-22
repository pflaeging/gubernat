#! /bin/sh

name=$1
cn=$2

openssl genrsa -out ${name}_key.pem 2048
openssl req -new -key ${name}_key.pem -out ${name}_csr.pem -subj "/CN=${cn}"
openssl x509 -req -in ${name}_csr.pem -sha256 -days 365 -extensions v3_ca -signkey ${name}_key.pem -CAcreateserial -out ${name}_cert.pem
kubectl create secret tls ${name} --cert=${name}_cert.pem --key=${name}_key.pem --dry-run=client -o yaml
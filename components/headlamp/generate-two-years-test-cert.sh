#! /bin/sh

openssl req -new -newkey rsa:4096 -days 730 -nodes -x509 \
    -subj "/C=AT/CN=testcert for headlamp pleasse replace me" \
    -keyout headlamp-test-cert.key  -out headlamp-test-cert.crt 2>/dev/null
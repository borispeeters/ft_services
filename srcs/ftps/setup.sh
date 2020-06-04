#!/bin/sh
mkdir -p /ftps/bpeeters

openssl req -x509 -nodes -days 7300 -newkey rsa:2048 -subj "/C=NL/ST=Noord-Holland/O=Codam 42/CN=services" -keyout /etc/ssl/private/vsftpd.pem -out /etc/ssl/private/vsftpd.pem
chmod 600 /etc/ssl/private/vsftpd.pem

adduser -h /ftps/bpeeters -D bpeeters
echo "bpeeters:fluffclub" | chpasswd

/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf
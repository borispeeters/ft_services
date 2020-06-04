FROM alpine:latest

RUN apk update \
	&& apk add nginx \
	&& apk add openssl \
	&& apk add openssh \
    && mkdir /var/run/nginx/ \
	&& rm -f /var/cache/apk/*

RUN adduser -D -g 'www' www \
	&& mkdir /www \
	&& chown -R www:www /var/lib/nginx \
	&& chown -R www:www /www


RUN addgroup sshgroup \
	&& adduser -D bpeeters \
	&& echo "bpeeters:fluffclub" | chpasswd \
	&& ssh-keygen -A
	
# SSH
COPY sshd_config /etc/ssh/sshd_config

# SSL
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj '/C=NL/ST=Noord-Holland/O=Codam/CN=services' -keyout /etc/ssl/services.key -out /etc/ssl/services.crt

COPY nginx.conf /etc/nginx/
COPY index.html /www/

EXPOSE 80 443 22000

COPY setup.sh .
RUN chmod +x setup.sh

CMD ./setup.sh

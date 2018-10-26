FROM alpine:3.8
LABEL maintainer "Carl Mercier <foss@carlmercier.com>"
LABEL caddy_version="0.11.00" architecture="amd64"

RUN apk add --no-cache openssh-client git tar curl ca-certificates bash && update-ca-certificates

RUN mkdir -p /opt/assets

ENV GANDIV5_API_KEY=

EXPOSE 80 443 2015

VOLUME /var/www
VOLUME /caddy
WORKDIR /var/www
WORKDIR /caddy

ENV CADDYPATH=/caddy/.caddy
ENV RUN_ARGS=

COPY Caddyfile /caddy/
COPY index.html /var/www/
COPY Caddyfile /opt/assets/
COPY index.html /opt/assets/
COPY start.sh /

ENV PLUGINS=dyndns,hook.service,http.authz,http.awses,http.awslambda,http.cache,http.cgi,http.cors,http.datadog,http.expires,http.filemanager,http.filter,http.forwardproxy,http.geoip,http.git,http.gopkg,http.grpc,http.hugo,http.ipfilter,http.jekyll,http.jwt,http.locale,http.login,http.mailout,http.minify,http.nobots,http.prometheus,http.proxyprotocol,http.ratelimit,http.realip,http.reauth,http.restic,http.upload,http.webdav,net,tls.dns.gandi,tls.dns.gandiv5
ENTRYPOINT ["/start.sh"]

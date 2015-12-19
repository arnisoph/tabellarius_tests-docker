FROM debian:jessie
MAINTAINER Arnold Bechtoldt <mail@arnoldbechtoldt.com>

RUN export DEBIAN_FRONTEND=noninteractive; \
    apt-get update -qq && \
    apt-get upgrade -yV -o DPkg::Options::=--force-confold && \
    apt-get install -yV -o DPkg::Options::=--force-confold \
        dovecot-core \
        dovecot-imapd \
        redis-server \
        rng-tools

RUN apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY data/ /data/
CMD /usr/sbin/dovecot -c /data/configs/dovecot.conf; \
    /usr/sbin/rngd -r /dev/random; \
    /usr/bin/redis-server /data/configs/redis.conf; \
    tail -f /var/log/dovecot.log

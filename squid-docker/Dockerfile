FROM debian:12

RUN apt update && apt install -y squid

COPY squid.conf /etc/squid/squid.conf

EXPOSE 3128

CMD ["squid", "-N", "-d", "1"]

FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y nginx openssl && \
    apt-get clean

COPY tools/setup.sh /setup.sh
RUN chmod +x /setup.sh

COPY conf/default.conf /etc/nginx/sites-available/default

RUN mkdir -p /etc/nginx/ssl

EXPOSE 443

CMD ["/setup.sh"]

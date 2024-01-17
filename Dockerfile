FROM ubuntu

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get -y --no-install-recommends install -y cron curl \
    # Remove package lists for smaller image sizes
    && rm -rf /var/lib/apt/lists/* \
    && which cron \
    && rm -rf /etc/cron.*/*

COPY crontab /equalify-cron
COPY entrypoint.sh /entrypoint.sh

RUN crontab equalify-cron
RUN chmod +x entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

CMD ["cron","-f", "-L", "2"]

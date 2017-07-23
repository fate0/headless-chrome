FROM ubuntu:16.04
MAINTAINER fate0 <fate0@fatezero.org>


ARG CHROME_BRANCH
ENV CHROME_BRANCH $CHROME_BRANCH


RUN apt-get update -qqy\
    && apt-get install -qqy wget\
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/*


RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list \
    && apt-get update -qqy\
    && apt-get install -qqy google-chrome-$CHROME_BRANCH \
    && rm /etc/apt/sources.list.d/google.list \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/*


RUN mkdir /data

ENTRYPOINT ["/usr/bin/google-chrome", \
            "--disable-gpu", \
            "--headless", \
            "--remote-debugging-address=0.0.0.0", \
            "--remote-debugging-port=9222", \
            "--user-data-dir=/data"]

FROM python:latest

MAINTAINER marcel@marquez.fr

ARG branch_name=master

RUN apt-get update && apt-get -y install cron wget unzip python-pyqt5
RUN wget https://tinfoil.io/repo/nut.src.latest.zip && \
    unzip nut.src.latest.zip -d /root && \
    cd /root/nut.src.latest && \
    pip3 install colorama pyopenssl requests tqdm unidecode Pillow BeautifulSoup4 urllib3 Flask pyusb google-api-python-client google-auth-oauthlib

COPY /entrypoint.sh /
COPY conf /root/nut.src.latest/conf

RUN chmod +x /entrypoint.sh

RUN touch /var/log/cron.log && touch /var/log/nut.log

EXPOSE 9000

ENTRYPOINT ["sh", "/entrypoint.sh"]


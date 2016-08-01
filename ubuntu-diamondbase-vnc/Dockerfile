#FROM localreg:5000/diamondbase:14.04
FROM localreg:5000/diamond-java8:14.04
MAINTAINER "zhangjun <ibmzhangjun@icloud.com>"

RUN mkdir -p /data
ENV DEBIAN_FRONTEND noninteractive
ENV HOME /data
ENV MYAPPNAME vncdesktop
ENV HOME /root
WORKDIR /root

#Change hosts refresh to 10 minutes
RUN rm /usr/bin/confd-start.sh
COPY confd-start.sh /usr/bin/confd-start.sh
RUN chmod 755 /usr/bin/confd-start.sh

#Add sources
RUN mkdir -p /sources
COPY sources/* /sources/
#RUN	/sources/source-change-to-local

#Upgraded ubuntu & Install you app here
#RUN apt-get update && apt-get install -qy apache2 && apt-get clean

COPY google-chrome-stable_current_amd64.deb /home/google-chrome-stable_current_amd64.deb
COPY ideaIC-2016.2.tar.gz /home/ideaIC-2016.2.tar.gz
COPY scala-intellij-bin-2016.2.1.zip /home/scala-intellij-bin-2016.2.1.zip
RUN apt-get update \
    && apt-get install -qy supervisor \
        pwgen sudo vim-tiny x11vnc x11vnc-data \
        net-tools \
        lxde x11vnc xvfb \
        gtk2-engines-murrine ttf-ubuntu-font-family \
        firefox \
        fonts-wqy-microhei \
        nginx \
	ssh \
        python-pip python-dev build-essential python-setuptools \
        mesa-utils libgl1-mesa-dri \
        gconf-service libnspr4 libnss3 fonts-liberation \
        libappindicator1 libcurl3 fonts-wqy-microhei
RUN dpkg -i /home/google-chrome-stable_current_amd64.deb \
    && apt-get install -f \
    && apt-get autoclean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/*

ADD web /web/
RUN pip install -r /web/requirements.txt

ADD noVNC /noVNC/
ADD nginx.conf /etc/nginx/sites-enabled/default
ADD startup.sh /usr/bin/
RUN chmod 755 /usr/bin/startup.sh
ADD supervisord.conf /etc/supervisor/conf.d/
ADD doro-lxde-wallpapers /usr/share/doro-lxde-wallpapers/


## ADD start script
# you need to select what you want and uncommon the lines below
##
#If you want to start as a service, the app will not be killed forever

#RUN mkdir /etc/service/$MYAPPNAME
#ADD svsstart.sh /etc/service/$MYAPPNAME/run

#If Just start at boot
ADD svsstart.sh /etc/my_init.d/$MYAPPNAME.sh

#Clean
RUN apt-get purge -y --auto-remove && rm /home/google-chrome-stable_current_amd64.deb
RUN rm -rf /var/lib/apt/lists/*

#END
EXPOSE 22 6080
VOLUME ["/data"]

CMD ["/sbin/my_init"]

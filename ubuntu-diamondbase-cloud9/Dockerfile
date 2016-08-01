FROM localreg:5000/node:6.3
MAINTAINER "zhangjun <ibmzhangjun@icloud.com>"

RUN mkdir -p /workspace
ENV DEBIAN_FRONTEND noninteractive
ENV HOME /root
ENV MYAPPNAME cloud9
ENV NODE_ENV production

#Change hosts refresh to 10 minutes
RUN rm /usr/bin/confd-start.sh
COPY confd-start.sh /usr/bin/confd-start.sh
RUN chmod 755 /usr/bin/confd-start.sh

#Add sources
RUN mkdir -p /sources
COPY sources/* /sources/
#RUN	/sources/source-change-to-local

#Upgraded ubuntu & Install you app here
RUN apt-get update && apt-get install -qy tmux build-essential g++ curl libssl-dev apache2-utils git libxml2-dev sshfs && apt-get clean

# ------------------------------------------------------------------------------
# Install Cloud9
#RUN git clone https://github.com/c9/core.git /cloud9
ADD cloud9.tar /
WORKDIR /cloud9
RUN scripts/install-sdk.sh

# Tweak standlone.js conf
RUN sed -i -e 's_127.0.0.1_0.0.0.0_g' /cloud9/configs/standalone.js

# install npm install deployd -g
RUN npm install -g deployd
RUN npm install -g bower


# ------------------------------------------------------------------------------
# Add volumes
VOLUME /workspace

## ADD start script
# you need to select what you want and uncommon the lines below
##
#If you want to start as a service, the app will not be killed forever

#RUN mkdir /etc/service/$MYAPPNAME
#ADD svsstart.sh /etc/service/$MYAPPNAME/run

#If Just start at boot
ADD svsstart.sh /etc/my_init.d/$MYAPPNAME.sh

#Clean
RUN apt-get purge -y --auto-remove
RUN rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

#END
EXPOSE 22 80 3000

# Add supervisord conf
ADD cloud9.conf /etc/supervisor/conf.d/
CMD ["/sbin/my_init"]

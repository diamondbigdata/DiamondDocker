FROM localreg:5000/diamondbase:14.04
#FROM localreg:5000/diamond-java8:14.04
MAINTAINER "zhangjun <ibmzhangjun@icloud.com>"

RUN mkdir -p /data
ENV DEBIAN_FRONTEND noninteractive
ENV HOME /data
ENV MYAPPNAME gateone

ENV GATEONE_REPO_URL https://github.com/liftoff/GateOne.git

#Change hosts refresh to 10 minutes
RUN rm /usr/bin/confd-start.sh
COPY confd-start.sh /usr/bin/confd-start.sh
RUN chmod 755 /usr/bin/confd-start.sh

#Add sources
RUN mkdir -p /sources
COPY sources/* /sources/
#RUN	/sources/source-change-to-local

#Upgraded ubuntu & Install you app here
#RUN apt-get update && apt-get install -qy nmon && apt-get clean
# Ensure everything is up-to-date
RUN apt-get update --fix-missing && apt-get -y upgrade

# Install dependencies
RUN apt-get update && apt-get -y \
    install python-pip \
    python-imaging \
    python-setuptools \
    python-mutagen \
    python-pam \
    python-dev \
    git \
    telnet \
    openssh-client && \
    apt-get -y clean && \
    apt-get -q -y autoremove
RUN pip install --upgrade futures tornado cssmin slimit psutil

# Create the necessary directories, clone the repo, and install everything
RUN mkdir -p /gateone
ADD GateOne.tar /gateone
RUN mkdir -p /gateone/logs && \
    mkdir -p /gateone/users && \
    mkdir -p /etc/gateone/conf.d && \
    mkdir -p /etc/gateone/ssl && \
    cd /gateone && \
    cd GateOne && \
    python setup.py install && \
    cp docker/update_and_run_gateone.py /usr/local/bin/update_and_run_gateone && \
    cp docker/60docker.conf /etc/gateone/conf.d/60docker.conf
    
# This ensures our configuration files/dirs are created:
RUN /usr/local/bin/gateone --configure \
    --log_file_prefix="/gateone/logs/gateone.log"
    
# Remove the auto-generated key/certificate so that a new one gets created the
# first time the container is started:
RUN rm -f /etc/gateone/ssl/key.pem && \
    rm -f /etc/gateone/ssl/certificate.pem
# (We don't want everyone using the same SSL key/certificate)


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

#END
EXPOSE 22 8000
VOLUME ["/data"]

CMD ["/sbin/my_init"]

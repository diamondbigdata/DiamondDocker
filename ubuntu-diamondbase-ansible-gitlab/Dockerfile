FROM localreg:5000/diamondbase:14.04
#FROM localreg:5000/diamond-java8:14.04
MAINTAINER "zhangjun <ibmzhangjun@icloud.com>"

RUN mkdir -p /data
ENV DEBIAN_FRONTEND noninteractive
ENV HOME /data
ENV MYAPPNAME agj

#Change hosts refresh to 10 minutes
RUN rm /usr/bin/confd-start.sh
COPY confd-start.sh /usr/bin/confd-start.sh
RUN chmod 755 /usr/bin/confd-start.sh

#Add sources
RUN mkdir -p /sources
COPY sources/* /sources/
#RUN	/sources/source-change-to-local

#Upgraded ubuntu & Install ansible
RUN apt-get update && apt-get install --no-install-recommends -y git curl zip unzip software-properties-common ca-certificates wget openssh-server apt-transport-https vim nano && \
	  apt-add-repository -y ppa:ansible/ansible && \
	  apt-get update && \
	  apt-get install -y ansible &&\
	  apt-get clean

# Download & Install GitLab
# If you run GitLab Enterprise Edition point it to a location where you have downloaded it.
RUN echo "deb https://packages.gitlab.com/gitlab/gitlab-ce/ubuntu/ `lsb_release -cs` main" > /etc/apt/sources.list.d/gitlab_gitlab-ce.list
RUN wget -q -O - https://packages.gitlab.com/gpg.key | apt-key add -
RUN apt-get update
COPY gitlab-ce_8.10.2-ce.0_amd64.deb /var/cache/apt/archives/gitlab-ce_8.10.2-ce.0_amd64.deb
RUN apt-get install -yq --no-install-recommends gitlab-ce
RUN echo "UseDNS no" >> /etc/ssh/sshd_config
RUN ( \
  echo "" && \
  echo "# Docker options" && \
  echo "# Prevent Postgres from trying to allocate 25% of total memory" && \
  echo "postgresql['shared_buffers'] = '1MB'" ) >> /etc/gitlab/gitlab.rb && \
  mkdir -p /assets/ && \
  cp /etc/gitlab/gitlab.rb /assets/gitlab.rb
COPY assets/wrapper /usr/local/bin/

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
EXPOSE 22 80 443
VOLUME ["/data", "/etc/gitlab", "/var/opt/gitlab", "/var/log/gitlab"]

CMD ["/sbin/my_init"]

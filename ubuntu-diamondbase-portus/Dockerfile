FROM localreg:6000/node:6.3
#FROM localreg:5000/diamond-java8:14.04
MAINTAINER "zhangjun <ibmzhangjun@icloud.com>"

RUN mkdir -p /data
ENV DEBIAN_FRONTEND noninteractive
ENV HOME /root
ENV MYAPPNAME portus

#Change hosts refresh to 10 minutes
RUN rm /usr/bin/confd-start.sh
COPY confd-start.sh /usr/bin/confd-start.sh
RUN chmod 755 /usr/bin/confd-start.sh

#Add sources
RUN mkdir -p /sources
COPY sources/* /sources/
#RUN	/sources/source-change-to-local

#Upgraded ubuntu & Install you app here
RUN apt-get update && apt-get install -qy git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev && apt-get clean
RUN cd ~ \
    && git clone git://github.com/sstephenson/rbenv.git .rbenv \
    && echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile \
    && echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
ADD ruby-build.tar /root/.rbenv/plugins/
#RUN cd ~ && git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build \
RUN ls -l /root/.rbenv/plugins/ruby-build/bin/ && echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bash_profile
#RUN cat ~/.bash_profile
ENV PATH=$HOME/.rbenv/bin:$HOME/.rbenv/plugins/ruby-build/bin:$PATH
RUN eval "$(rbenv init -)"
RUN /bin/bash -c "source ~/.bash_profile" \
		&& rbenv install -v 2.1.2 \
    && rbenv global 2.1.2 \
    && echo "gem: --no-document" > ~/.gemrc
RUN /bin/bash -l -c "gem install bundler"
RUN /bin/bash -l -c "gem install rails -v 4.2.2"
RUN rbenv rehash \
    && ruby -v \
    && rails -v \
    && git clone https://github.com/SUSE/Portus.git /Portus
RUN cd /Portus \
    && bundle config build.nokogiri --use-system-libraries \
    && bundle install --retry=3 \

## ADD start script
# you need to select what you want and uncommon the lines below
##
#If you want to start as a service, the app will not be killed forever

#RUN mkdir /etc/service/$MYAPPNAME
#ADD svsstart.sh /etc/service/$MYAPPNAME/run

#If Just start at boot
#ADD svsstart.sh /etc/my_init.d/$MYAPPNAME.sh

#Clean
RUN apt-get install -y --no-install-recommends phantomjs && apt-get purge -y --auto-remove
RUN rm -rf /var/lib/apt/lists/*

#END
EXPOSE 22
VOLUME ["/data"]

CMD ["/sbin/my_init"]

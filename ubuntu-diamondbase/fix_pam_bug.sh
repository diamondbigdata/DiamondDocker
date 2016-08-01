#!/bin/bash
set -e
source /bd_build/buildconfig
set -x

# Fixes https://github.com/docker/docker/issues/6345
# The Github is closed, but some apps such as pbuilder still triggers it.

export CONFIGURE_OPTS=--disable-audit
cd /tmp



apt-get build-dep -y --no-install-recommends pam
export CONFIGURE_OPTS=--disable-audit && cd /tmp && apt-get -b source pam && dpkg -i libpam-doc*.deb libpam-modules*.deb libpam-runtime*.deb libpam0g*.deb && apt-get autoremove -y

# Unfortunately there is no way to automatically remove build deps, so we do this manually.
apt-get remove -y autoconf automake autopoint autotools-dev binutils bsdmainutils \
	build-essential bzip2 cpp debhelper dh-autoreconf \
	diffstat docbook-xml docbook-xsl dpkg-dev flex g++ gcc gettext gettext-base \
	groff-base intltool-debian libatomic1 \
	libaudit-dev libc-dev-bin libc6-dev libcrack2 libcrack2-dev libcroco3 \
	libdb-dev libdb5.3-dev libdpkg-perl libfl-dev libgc1c2 \
	libgdbm3 libgomp1 libgpm2 libitm1 libmpc3 \
	libmpfr4 libpcre3-dev \
	libpipeline1 libquadmath0 libselinux1-dev libsepol1-dev libsigsegv2 \
	libtimedate-perl libtool libtsan0 libunistring0 libxml2 libxml2-utils \
	libxslt1.1 linux-libc-dev m4 make man-db patch perl pkg-config \
	po-debconf quilt sgml-base sgml-data w3m xml-core xsltproc xz-utils

apt-get install -y --no-install-recommends openssh-server syslog-ng-core

apt-get autoremove -y
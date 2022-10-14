FROM ubuntu:focal
## Have to use this due to default interactive tzdata config
ARG DEBIAN_FRONTEND=noninteractive

SHELL ["/bin/bash", "-c"]

RUN apt-get update && apt-get upgrade -y && apt-get install -y apt-utils gpg libssl-dev ca-certificates git host

RUN echo 'deb [trusted=yes] http://linux.dell.com/repo/community/openmanage/10300/focal focal main' | tee -a /etc/apt/sources.list.d/linux.dell.com.sources.list
RUN gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-key 1285491434D8786F 
RUN gpg -a --export 1285491434D8786F | apt-key add -

RUN apt-get update && apt-get install -y --no-install-recommends srvadmin-hapi; exit 0
RUN echo $'#!/bin/bash\n\
/bin/true' > /var/lib/dpkg/info/srvadmin-hapi.postinst
RUN echo $'#!/bin/bash\n\
/bin/true' > /var/lib/dpkg/info/srvadmin-idracadm8.postinst
RUN dpkg --configure -a
RUN apt-get install -y --no-install-recommends srvadmin-idracadm7; exit 0
RUN echo $'#!/bin/bash\n\
/bin/true' > /var/lib/dpkg/info/srvadmin-idracadm7.postinst
RUN apt-get install -y --no-install-recommends srvadmin-idracadm7
RUN apt-get install -y --no-install-recommends srvadmin-idracadm8; exit 0
RUN echo $'#!/bin/bash\n\
/bin/true' > /var/lib/dpkg/info/srvadmin-idracadm8.postinst
RUN apt-get install -y --no-install-recommends srvadmin-idracadm8
RUN chmod +x /opt/dell/srvadmin/sbin/racadm

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
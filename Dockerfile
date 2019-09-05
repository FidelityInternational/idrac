FROM centos:7

RUN yum update -y && yum install -y wget perl openssl-devel git bind-utils
RUN rpm --import http://linux.dell.com/repo/pgp_pubkeys/0x1285491434D8786F.asc
RUN wget -q -O - http://linux.dell.com/repo/hardware/latest/bootstrap.cgi | bash

RUN yum install -y srvadmin-idrac

ENTRYPOINT ["/opt/dell/srvadmin/bin/idracadm"]

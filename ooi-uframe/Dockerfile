# OOI uFrame (Unofficial)
# Author: Raytheon

FROM oceanzus/ooi-base-image
MAINTAINER James D. Case <case@oceanz.org>

RUN yum -y install libgfortran; yum clean all

RUN adduser uframe
RUN echo "uframe ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

RUN echo "developer    -    nproc    10000" >> /etc/security/limits.conf
RUN echo "developer    -    nofile   10000" >> /etc/security/limits.conf

ADD start_uframe.sh /home/uframe/start_uframe.sh
RUN chmod +x /home/uframe/start_uframe.sh

ADD load_data.sh /home/uframe/load_data.sh
RUN chmod +x /home/uframe/load_data.sh

CMD [ "/bin/bash", "-c", "/home/uframe/start_uframe.sh" ]

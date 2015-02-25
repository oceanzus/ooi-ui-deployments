# OOI uFrame (Unofficial)
# Author: Raytheon

FROM oceanzus/ooi-base-image
MAINTAINER James D. Case <case@oceanz.org>

RUN yum -y install libgfortran; yum clean all

RUN adduser uframe
RUN echo "uframe ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

ADD start_uframe.sh /home/uframe/start_uframe.sh
RUN chmod +x /home/uframe/start_uframe.sh

CMD [ "/bin/bash", "-c", "/home/uframe/start_uframe.sh" ]

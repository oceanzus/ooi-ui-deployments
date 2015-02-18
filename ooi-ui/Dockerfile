# OOI UI
# <https://github.com/oceanzus/ooi-ui-deployments.git>
# Author: RPS ASA
# Usage: <https://github.com/asascience-open/ooi-ui/wiki/Automated-Deployment-(Docker)>

FROM oceanzus:ooi-base-image
MAINTAINER James D. Case <case@oceanz.org>

# OOI UI Installation
RUN git clone https://github.com/asascience-open/ooi-ui.git /root/ooi-ui
WORKDIR /root/ooi-ui
RUN /bin/bash -c "source /root/.venvburrito/startup.sh \
    && workon ooiui \
    && pip install -r requirements.txt"

# Install Node.js
WORKDIR /tmp
RUN wget http://nodejs.org/dist/v0.10.35/node-v0.10.35-linux-x64.tar.gz
WORKDIR /usr/local
RUN tar --strip-components 1 -xzf /tmp/node-v0.10.35-linux-x64.tar.gz
RUN rm -rf /tmp/node-v0.10.35-linux-x64.tar.gz
WORKDIR /root/ooi-ui
RUN npm install -g grunt-cli
RUN npm install -g bower
RUN npm install

RUN bower install -s --allow-root
RUN grunt

ADD start_ooi-ui.sh /root/ooi-ui/start_ooi-ui.sh
RUN chmod +x /root/ooi-ui/start_ooi-ui.sh

EXPOSE 5000

CMD [ "/bin/bash", "-c", "/root/ooi-ui/start_ooi-ui.sh" ]


#!/bin/bash
source ~/.bash_profile
workon ooiui
export PYTHONPATH=$PYTHONPATH:.
sed -i -e 's/SERVICES_URL: http:\/\/localhost:4000/SERVICES_URL: http:\/\/ooiuiservices:4000/g' ooiui/config/config.yml
lip="$(/sbin/ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}')"
sed -i -e "s/localhost/$lip/g" app.py
python app.py -s

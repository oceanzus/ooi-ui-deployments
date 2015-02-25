#!/bin/bash
source ~/.bash_profile
workon ooiui
export PYTHONPATH=$PYTHONPATH:.
sed -i -e 's/SERVICES_URL: http:\/\/localhost:4000/SERVICES_URL: http:\/\/ooiuiservices:4000/g' ooiui/config/config.yml

# UI_API_KEY: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
sed -i -e "s|UI_API_KEY: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx|UI_API_KEY: $UI_API_KEY|g" ooiui/config/config.yml

# SECRET_KEY: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
sed -i -e "s|SECRET_KEY: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx|SECRET_KEY: $SECRET_KEY|g" ooiui/config/config.yml

lip="$(/sbin/ifconfig $HOST_NIC | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}')"
sed -i -e "s/localhost/$lip/g" app.py
python app.py -s

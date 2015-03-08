#!/bin/bash
source ~/.bash_profile
workon ooiui
export PYTHONPATH=$PYTHONPATH:.

sed -i -e "s|data_root: '..'|data_root: '$MUFRAME_DATA_ROOT'|g" muframe.yml
sed -i -e "s|data_folder: 'data'|data_folder: '$MUFRAME_DATA_FOLDER'|g" muframe.yml
sed -i -e "s|uframe_url: 'http://localhost:12575'|uframe_url: '$MUFRAME_UFRAME_URL'|g" muframe.yml
sed -i -e "s|uframe_url_root: '/sensor/inv'|uframe_url_root: '$MUFRAME_UFRAME_URL_ROOT'|g" muframe.yml
sed -i -e "s|uframe_timeout_connect: 5|uframe_timeout_connect: $MUFRAME_UFRAME_TIMEOUT_CONNECT|g" muframe.yml
sed -i -e "s|uframe_timeout_read: 30|uframe_timeout_read: $MUFRAME_UFRAME_TIMEOUT_READ|g" muframe.yml
sed -i -e "s|host: 127.0.0.1|host: $MUFRAME_HOST|g" muframe.yml
sed -i -e "s|port: 7090|port: $MUFRAME_PORT|g" muframe.yml
sed -i -e "s|timeout: 60|timeout: $MUFRAME_TIMEOUT|g" muframe.yml
sed -i -e "s|preload: False|preload: $MUFRAME_PRELOAD|g" muframe.yml

python muframe.py

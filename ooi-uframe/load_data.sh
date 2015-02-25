#!/bin/bash

cd ~/
source ~/.bash_profile
source ~/ooi-cas/bin/edex-server

python /home/uframe/tmp/uframe_ingest/ingest/dataIngest.py -n 5 -d 1 -a -i /home/uframe/tmp/uframe_ingest/CP02PMCO/ingest_CP02PMCO_D00001.xlsx -e ~/ooi-cas/uframe-1.0/edex/

cp /home/uframe/tmp/uframe_ingest/CP02PMCO/Omaha_Cal_Info_CP02PMCO_00002.xlsx ~/ooi-cas/uframe-1.0/edex/data/ooi/asset_spreadsheet/

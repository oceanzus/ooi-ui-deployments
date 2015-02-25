#!/bin/bash

cd /home/uframe/
source /home/uframe/.bash_profile
source /home/uframe/ooi-cas/bin/edex-server

python /home/uframe/tmp/uframe_ingest/ingest/dataIngest.py -n 5 -d 1 -a -i /home/uframe/tmp/uframe_ingest/CP02PMCO/ingest_CP02PMCO_D00001.xlsx -e /home/uframe/ooi-cas/uframe-1.0/edex/

cp /home/uframe/tmp/uframe_ingest/CP02PMCO/Omaha_Cal_Info_CP02PMCO_00002.xlsx /home/uframe/ooi-cas/uframe-1.0/edex/data/ooi/asset_spreadsheet/

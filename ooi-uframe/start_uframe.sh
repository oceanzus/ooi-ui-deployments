#!/bin/bash
su - uframe
mkdir /home/uframe/tmp
cp /home/uframe/source/ooi-cass_cd08b5e.tar.gz /home/uframe/tmp/
tar -xzvf /home/uframe/tmp/ooi-cass_cd08b5e.tar.gz -C /home/uframe
mv /home/uframe/ooi /root/ooi-cas
source ~/ooi-cas/bin/edex-server

cp /home/uframe/source/uframe_ingest.tar.gz /home/uframe/tmp/
gunzip /home/uframe/uframe_ingest.tar.gz
tar -xvf /home/uframe/tmp/uframe_ingest.tar
gunzip /home/uframe/tmp/uframe_ingest/ingest_config_spreadsheets.tar.gz
tar -xvf /home/uframe/tmp/uframe_ingest/ingest_config_spreadsheets.tar

python /home/uframe/tmp/uframe_ingest/ingest/dataIngest.py -n 5 -d 1 -a -i /home/uframe/tmp/uframe_ingest/ingest_config_spreadsheets/CP02PMCO/ingest_CP02PMCO_D00001.xlsx -e ~/ooi-cas/uframe-1.0/edex/

cp /home/uframe/uframe_ingest/ingest_config_spreadsheets/CP02PMCO/Omaha_Cal_Info_CP02PMCO_00002.xlsx ~/ooi-cas/uframe-1.0/edex/data/ooi/asset_spreadsheet/

echo "export PATH=$PATH:/home/uframe/ooi-cas/uframe-1.0/java/bin" >> /home/uframe/.bash_profile

source ~/.bash_profile
source ~/ooi-cas/bin/edex-server

/home/uframe/ooi-cas/uframe-1.0/cassandra/bin/cassandra -p ~/cass.pid &
/home/uframe/ooi-cas/bin/edex-server all start &

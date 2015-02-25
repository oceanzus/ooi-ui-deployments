#!/bin/bash
su - uframe
mkdir /home/uframe/tmp
cp /home/uframe/source/ooi-cass_cd08b5e.tar.gz /home/uframe/tmp/
tar -xzvf /home/uframe/tmp/ooi-cass_cd08b5e.tar.gz -C /home/uframe
mv /home/uframe/ooi /home/uframe/ooi-cas
source /home/uframe/ooi-cas/bin/edex-server

cd /home/uframe/tmp
cp /home/uframe/source/uframe_ingest.tar.gz /home/uframe/tmp/
gunzip /home/uframe/tmp/uframe_ingest.tar.gz
tar -xvf /home/uframe/tmp/uframe_ingest.tar
cd /home/uframe/tmp/uframe_ingest
gunzip /home/uframe/tmp/uframe_ingest/ingest_config_spreadsheets.tar.gz
tar -xvf /home/uframe/tmp/uframe_ingest/ingest_config_spreadsheets.tar

cd /home/uframe/
echo "export PATH=$PATH:/home/uframe/ooi-cas/uframe-1.0/java/bin" >> /home/uframe/.bash_profile
source /home/uframe/.bash_profile
source /home/uframe/ooi-cas/bin/edex-server

/home/uframe/ooi-cas/uframe-1.0/cassandra/bin/cassandra -p /home/uframe/cass.pid &

/home/uframe/ooi-cas/bin/edex-server all start &

/home/uframe/load_data.sh

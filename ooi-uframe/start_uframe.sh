#!/bin/bash
#su - uframe
sudo mkdir /home/uframe/tmp
sudo cp /home/uframe/source/ooi-cass_cd08b5e.tar.gz /home/uframe/tmp/
sudo tar -xzvf /home/uframe/tmp/ooi-cass_cd08b5e.tar.gz -C /home/uframe
sudo chown -R uframe:uframe /home/uframe/ooi
sudo mv /home/uframe/ooi /home/uframe/ooi-cas
source /home/uframe/ooi-cas/bin/edex-server

cd /home/uframe/tmp
sudo cp /home/uframe/source/uframe_ingest.tar.gz /home/uframe/tmp/
sudo gunzip /home/uframe/tmp/uframe_ingest.tar.gz
sudo tar -xvf /home/uframe/tmp/uframe_ingest.tar
cd /home/uframe/tmp/uframe_ingest
sudo gunzip /home/uframe/tmp/uframe_ingest/ingest_config_spreadsheets.tar.gz
sudo tar -xvf /home/uframe/tmp/uframe_ingest/ingest_config_spreadsheets.tar

cd /home/uframe/
echo "export UFRAME1_HOME=/home/uframe/ooi-cas" >> /home/uframe/.bash_profile
echo "export JAVA_HOME=${UFRAME1_HOME}/uframe-1.0/java" >> /home/uframe/.bash_profile
echo "export PATH=${JAVA_HOME}/bin:${PATH}" >> /home/uframe/.bash_profile
#echo "export PATH=$PATH:/home/uframe/ooi-cas/uframe-1.0/java/bin" >> /home/uframe/.bash_profile
source /home/uframe/.bash_profile
source /home/uframe/ooi-cas/bin/edex-server

/home/uframe/ooi-cas/uframe-1.0/cassandra/bin/cassandra -p /home/uframe/cass.pid &

/home/uframe/ooi-cas/bin/edex-server all start &

/home/uframe/load_data.sh

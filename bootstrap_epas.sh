#!/bin/bash

echo "--- Running Bootstrap_epas.sh ---"
echo "--- Installing EPAS ---"
sudo dnf -y install edb-as16-server

sudo PGSETUP_INITDB_OPTIONS="-E UTF-8" /usr/edb/as16/bin/edb-as-16-setup initdb
sudo mkdir -p /var/lib/edb/as16/data/conf.d
sudo cp /vagrant/00-replication.conf /var/lib/edb/as16/data/conf.d
sudo chmod 700 /var/lib/edb/as16/data/conf.d
sudo chown -R enterprisedb:enterprisedb /var/lib/edb/as16/data/co
sudo systemctl start edb-as-16
sudo systemctl status edb-a
sudo su - enterprisedb -c "psql -c \"ALTER ROLE enterprisedb IDENTIFIED BY enterprisedb superuser;\" edb"
sudo su - enterprisedb -c "psql -c \"CREATE ROLE subuser IDENTIFIED BY subuser superuser;\" edb"
sudo su - enterprisedb -c "psql -c \"CREATE DATABASE subdb OWNER subuser;\" edb"

printf "--- Configuring pg_hba.conf ---"
sudo su - enterprisedb -c 'echo "
#Replication parameters
local   all             all                                 md5
host    edb             pubuser         192.168.0.0/16      md5
host    subdb           subuser         192.168.0.0/16      md5
host    all             all             127.0.0.1/32        md5

$(cat /var/lib/edb/as16/data/pg_hba.conf)" > /var/lib/edb/as16/data/pg_hba.conf'
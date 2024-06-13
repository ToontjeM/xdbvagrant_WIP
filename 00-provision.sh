#!/bin/bash

cd ~/vagrant-projects/OracleDatabase/19.3.0
vagrant up

echo "--- Setting up pubuser ---"
vagrant ssh -t << EOF
sudo su - oracle
sqlplus / as sysdba;
alter session set container = ORCLPDB1;
create user pubuser identified by pubuser;
GRANT CONNECT TO pubuser;
GRANT RESOURCE TO pubuser;
GRANT CREATE ANY TRIGGER TO pubuser;
GRANT LOCK ANY TABLE TO pubuser;
GRANT UNLIMITED TABLESPACE TO pubuser;
GRANT CREATE JOB TO pubuser;
EOF

ech0 "Setting up HR schema ---"
vagrant ssh -t << EOF
sudo sed -i '/^PROMPT/d' /opt/oracle/product/19c/dbhome_1/demo/schema/human_resources/hr_main.sql
sudo sed -i 's/&1/hr/g' /opt/oracle/product/19c/dbhome_1/demo/schema/human_resources/hr_main.sql
sudo sed -i 's/&2/users/g' /opt/oracle/product/19c/dbhome_1/demo/schema/human_resources/hr_main.sql
sudo sed -i 's/&3/temp/g' /opt/oracle/product/19c/dbhome_1/demo/schema/human_resources/hr_main.sql
sudo sed -i 's/&4/\$ORACLE_HOME\/demo\/schema\/log\//g' /opt/oracle/product/19c/dbhome_1/demo/schema/human_resources/hr_main.sql
sudo su - oracle
sqlplus / as sysdba;
@?/demo/schema/human_resources/hr_main.sql
EOF

cd ~/xdbvagrant
vagrant up

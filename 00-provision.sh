#!/bin/bash

cd ~/vagrant-projects/OracleDatabase/18.4.0-XE
vagrant up

vagrant ssh -c <<EOF
sqlplus / as sysdba;
alter session set container = XEPDB1;
create user pubuser identified by pubuser;
GRANT CONNECT TO pubuser;
GRANT RESOURCE TO pubuser;
GRANT CREATE ANY TRIGGER TO pubuser;
GRANT LOCK ANY TABLE TO pubuser;
GRANT UNLIMITED TABLESPACE TO pubuser;
EOF

cd ~/xdbvagrant
vagrant up

#!/bin/bash

echo "--- Running Bootstrap_xdb.sh ---"
echo "--- Installing xDB, EDB JDBC and Oracle JDBC ---"
dnf -y install edb-jdbc edb-xdb xorg-x11-xauth 
wget https://download.oracle.com/otn-pub/otn_software/jdbc/234/ojdbc11.jar
cp ojdbc11.jar /usr/edb/xdb/lib/jdbc

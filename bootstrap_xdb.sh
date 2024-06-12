#!/bin/bash

echo "--- Running Bootstrap_xdb.sh ---"
echo "--- Installing xDB, EDB JDBC and Oracle JDBC ---"
dnf -y install edb-jdbc edb-xdb xorg-x11-xauth edb-migrationtoolkit

wget https://download.oracle.com/otn-pub/otn_software/jdbc/234/ojdbc11.jar
cp ojdbc11.jar /usr/edb/xdb/lib/jdbc

systemctl enable edb-xdbpubserver
systemctl start edb-xdbpubserver
systemctl status edb-xdbpubserver

systemctl enable edb-xdbsubserver
systemctl start edb-xdbsubserver
systemctl status edb-xdbsubserver

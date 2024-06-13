#!/bin/bash

echo "--- Running Bootstrap_xdb.sh ---"
echo "--- Installing xDB, EDB JDBC and Oracle JDBC ---"
dnf -y install edb-jdbc edb-xdb xorg-x11-xauth edb-migrationtoolkit

sudo wget https://download.oracle.com/otn-pub/otn_software/jdbc/234/ojdbc11.jar -P /usr/edb/jdbc
sudo ln -s /usr/edb/jdbc/ojdbc11.jar /usr/edb/xdb/lib/jdbc/ojdbc.jar

echo "--- Setting admin password to 'admin' ---"
sed -i -e 's/SJ70z8Gk0zY\\=/iSbB5Li2hOE\=/g' /etc/edb-repl.conf

systemctl enable edb-xdbpubserver
systemctl start edb-xdbpubserver
systemctl status edb-xdbpubserver

systemctl enable edb-xdbsubserver
systemctl start edb-xdbsubserver
systemctl status edb-xdbsubserver

echo "--- Replication Server installed ---"
echo "- You can now log in with userid 'admin' and password 'admin' -"
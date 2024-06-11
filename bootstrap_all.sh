#!/bin/bash

echo "--- Running Bootstrap_all.sh ---"

echo "--- Configuring repo ---"
EDBTOKEN=$(cat /vagrant/.edbtoken)

curl -1sLf https://downloads.enterprisedb.com/${EDBTOKEN}/enterprise/setup.rpm.sh | bash

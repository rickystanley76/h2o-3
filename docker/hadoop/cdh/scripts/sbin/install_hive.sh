#!/bin/bash -xe

HIVE_VERSION=$1

apt-get install -y ${HIVE_VERSION} ${HIVE_VERSION}-server2

find /usr/lib/hive/lib | grep 'jdbc-standalone' | tr '\n' ':' > /opt/hive-jdbc-cp

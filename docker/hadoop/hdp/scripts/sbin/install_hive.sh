#!/bin/bash -xe

HIVE_VERSION=$1

apt-get install -y ${HIVE_VERSION} ${HIVE_VERSION}-server2

find /usr/hdp/current/hive-client/lib | grep '.jar' | \
    grep -E 'hive-jdbc|hive-common|hive-exec|hive-service|libfb303|libthrift' | \
    tr '\n' ':' > /opt/hive-jdbc-cp

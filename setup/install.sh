#!/bin/bash

URL_PREFIX=
VERSION=1.1.2

if [ ! -f "hbase-$VERSION-bin.tar.gz" ]; then
    wget http://archive.apache.org/dist/hbase/${URL_PREFIX}${VERSION}/hbase-${VERSION}-bin.tar.gz
fi

tar xzf hbase-${VERSION}-bin.tar.gz -C /usr/lib/
ln -s /usr/lib/hbase-${VERSION} /usr/lib/hbase

# Remove unnecessary files
rm -rf /usr/lib/hbase/docs

# Remove archive
rm -rf /setup/*.gz

# Copy template
cp hbase-site.template /usr/lib/hbase/conf/

mv dockmobStart.sh /usr/lib/hbase/bin

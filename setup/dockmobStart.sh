#!/bin/bash

if [ ! -f /var/hbase/config_ok ];
then
    set -e

    usage() { echo "Usage: docker run [<docker options>] dockmob/hbase -t [pseudodistributed]" 1>&2; exit 1; }
    usagepseudodistributed() { echo "Usage: docker run [<docker options>] dockmob/hbase -t pseudodistributed" 1>&2; exit 1; }

    while getopts ":n:r:t:" o; do
        case "${o}" in
            t)
                t=${OPTARG}
                ;;
            *)
                usage
                ;;
        esac
    done
    shift $((OPTIND-1))

    if [ -z "${t}" ] || [ "${t}" != "pseudodistributed" ]; then
        usage
    elif [ "${t}" == "pseudodistributed" ]; then
        echo "Starting $t"

        HOSTNAME=$(cat /etc/hostname)

        echo "Hostname=$HOSTNAME"

        cp /usr/lib/hbase/conf/hbase-site.template /usr/lib/hbase/conf/hbase-site.xml

        ./hbase zookeeper > /var/log/zookeeper.log 2>&1 &
        ./hbase regionserver start > /var/log/regionserver.log 2>&1 &

        ./hbase master start --localRegionServers=0
    fi

    echo "$t" > /var/hbase/config_ok

else
    t=$(cat /var/hbase/config_ok)
    echo "Restarting $t"
    ./hbase zookeeper > /var/log/zookeeper.log 2>&1 &
    ./hbase regionserver start > /var/log/regionserver.log 2>&1 &
    ./hbase master start --localRegionServers=0
fi




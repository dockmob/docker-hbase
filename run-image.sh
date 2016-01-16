#docker run -p 2181:2181 -p 60000:60000 -p 60010:60010 -p 60020:60020 -p 60030:60030 -h hbase --entrypoint bash -it dockmob/hbase
docker run -p 2181:2181 -p 60000:60000 -p 60010:60010 -p 60020:60020 -p 60030:60030 -h hbase -it dockmob/hbase -t pseudodistributed

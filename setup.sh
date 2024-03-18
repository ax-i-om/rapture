#!/bin/bash
read -p "Solr host address [127.0.0.1]: " solrHOST
read -p "Solr port [8983]: " solrPORT
read -p "Solr shard count [4]: " solrSHARDS
read -p "Solr replication factor [1]: " solrREPLIC

if [ -z "$solrHOST" ]; then
   solrHOST=${name:-"127.0.0.1"}
fi

if [ -z "$solrPORT" ]; then
   solrPORT=${name:-"8983"}
fi

if [ -z "$solrSHARDS" ]; then
   solrSHARDS=${name:-"4"}
fi

if [ -z "$solrREPLIC" ]; then
   solrREPLIC=${name:-"1"}
fi

curl "http://$solrHOST:$solrPORT/solr/admin/collections?action=CREATE&name=BigData&numShards=$solrSHARDS&replicationFactor=$solrREPLIC&wt=json" 
curl "http://$solrHOST:$solrPORT/solr/BigData/config" -d '{"set-user-property": {"update.autoCreateFields":"false"}}'

while IFS="" read -r solrFIELD || [ -n "$solrFIELD" ]
do
    curl -X POST --data-raw $solrFIELD -H "Accept: application/json" "http://$solrHOST:$solrPORT/solr/BigData/schema?wt=json"
done < fields.txt
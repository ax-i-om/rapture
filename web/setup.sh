#!/bin/sh
if [ ! -f .initialized ]; then                                                                                                                                                                                    
   echo "Initializing Rapture"                                                                                                                                                                                 

   apk update; apk add curl

   solrHOST="solr1.internal"
   solrPORT="8983"
   solrSHARDS="4"
   solrREPLIC="1"

   timeout=5

   while [ "0" ];
   do
      sleep $timeout
      if curl "http://$solrHOST:$solrPORT/solr/admin/collections?action=CREATE&name=BigData&numShards=$solrSHARDS&replicationFactor=$solrREPLIC&wt=json" 
      then break
      fi
   done

   curl "http://$solrHOST:$solrPORT/solr/BigData/config" -d '{"set-user-property": {"update.autoCreateFields":"false"}}'

   while IFS="" read -r solrFIELD || [ -n "$solrFIELD" ]
   do
      curl -X POST --data-raw $solrFIELD -H "Accept: application/json" "http://$solrHOST:$solrPORT/solr/BigData/schema?wt=json"
   done < fields.txt

   touch .initialized                                                                                                                                                                                            
fi                                                                                                                                                                                                                

exec "$@"

/app/rapture-web

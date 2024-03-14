#!/bin/sh
host="127.0.0.1"
port="8983"
shards="4"
rep="1"

curl "http://$host:$port/solr/admin/collections?action=CREATE&name=BigData&numShards=$shards&replicationFactor=$rep&wt=json" 
curl "http://$host:$port/solr/BigData/config" -d '{"set-user-property": {"update.autoCreateFields":"false"}}'

addr="http://$host:$port/solr/BigData/schema?wt=json"

curl $addr -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"true","name":"asn","type":"pint","docValues":"true"}}'
curl $addr -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"true","name":"autoMake","type":"string","docValues":"true"}}'
curl $addr -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"true","name":"birthYear","type":"string","docValues":"true"}}'
curl $addr -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"true","name":"birthMonth","type":"string","docValues":"true"}}'
curl $addr -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"true","name":"birthday","type":"string","docValues":"true"}}'
curl $addr -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"true","name":"continent","type":"text_general"}}'
curl $addr -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"true","name":"country","type":"string","docValues":"true"}}'
curl $addr -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"true","name":"dob","type":"text_general"}}'
curl $addr -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"true","name":"domain","type":"text_general"}}'
curl $addr -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"true","name":"emails","type":"text_general"}}'
curl $addr -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"true","name":"ethnicity","type":"string","docValues":"true"}}'
curl $addr -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"true","name":"firstName","type":"text_general","uninvertible":"true"}}'
curl $addr -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"true","name":"middleName","type":"text_general","uninvertible":"true"}}'
curl $addr -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"true","name":"gender","type":"string","docValues":"true"}}'
curl $addr -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"true","uninvertible":"true","name":"ips","type":"string","multiValued":"true","omitNorms":"true","omitTermFreqAndPositions":"true","sortMissingLast":"true"}}'
curl $addr -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"true","name":"lastName","type":"text_general","uninvertible":"true"}}'
curl $addr -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"true","uninvertible":"true","name":"latLong","type":"location","docValues":"true"}}'
curl $addr -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"true","uninvertible":"true","name":"location","type":"text_general"}}'
curl $addr -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"true","name":"phoneNumbers","type":"text_general"}}'
curl $addr -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"true","name":"usernames","type":"text_general","uninvertible":"true"}}'
curl $addr -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"true","name":"vin","type":"text_general","uninvertible":"true"}}'
curl $addr -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"true","name":"zipCode","type":"string","uninvertible":"true"}}'
curl $addr -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"true","name":"VRN","type":"text_general","uninvertible":"true"}}'
curl $addr -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"true","uninvertible":"false","name":"accuracy_radius","type":"pint"}}'
curl $addr -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"true","uninvertible":"false","name":"address","type":"text_general"}}'
curl $addr -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"true","uninvertible":"false","name":"asnOrg","type":"text_general"}}'
curl $addr -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"true","uninvertible":"false","name":"autoBody","type":"string"}}'
curl $addr -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"true","uninvertible":"false","name":"autoClass","type":"string"}}'
curl $addr -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"true","uninvertible":"false","name":"autoModel","type":"string"}}'
curl $addr -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"true","uninvertible":"false","name":"autoYear","type":"string","docValues":"true"}}'
curl $addr -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"true","uninvertible":"false","name":"city","type":"text_general"}}'
curl $addr -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"true","uninvertible":"false","name":"passwords","type":"string","multiValued":"true"}}'
curl $addr -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"true","uninvertible":"false","name":"source","type":"string","docValues":"true"}}'
curl $addr -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"true","uninvertible":"false","name":"state","type":"string","docValues":"true"}}'
curl $addr -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"false","name":"income","type":"string"}}'
curl $addr -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"false","uninvertible":"false","name":"line","type":"string"}}'
curl $addr -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"false","uninvertible":"false","name":"links","type":"string","multiValued":"true"}}'
curl $addr -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"false","uninvertible":"false","name":"notes","type":"string","multiValued":"true"}}'
curl $addr -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"false","uninvertible":"false","name":"party","type":"string","multiValued":"true"}}'
curl $addr -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"false","uninvertible":"false","name":"photos","type":"string","multiValued":"true"}}'
$ip = Read-Host 'Enter IP address [127.0.0.1]'
$port = Read-Host 'Enter port [8983]'
$shards = Read-Host 'Enter shard count [4]'
$rep = Read-Host 'Enter replication factor [1]'

if ($ip -eq "" -or $null -eq $ip) {
    $ip = "127.0.0.1"
}
if ($port -eq "" -or $null -eq $port) {
    $port = "8983"
}
if ($shards -eq "" -or $null -eq $shards) {
    $shards = "4"
}
if ($rep -eq "" -or $null -eq $rep) {
    $rep = "1"
}

curl --url "http://${ip}:${port}/solr/admin/collections?action=CREATE&name=BigData&numShards=${shards}&replicationFactor=${rep}&wt=json" 
curl --url "http://${ip}:${port}/solr/BigData/config" -d '{"set-user-property": {"update.autoCreateFields":"false"}}'

$addr="http://${ip}:${port}/solr/BigData/schema?wt=json"

curl --url $addr --request POST --header 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"true","name":"asn","type":"pint","docValues":"true"}}'

curl --url $addr --request POST --header 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"true","name":"asn","type":"pint","docValues":"true"}}'
curl --url $addr --request POST --header 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"true","name":"autoMake","type":"string","docValues":"true"}}'
curl --url $addr --request POST --header 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"true","name":"birthYear","type":"string","docValues":"true"}}'
curl --url $addr --request POST --header 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"true","name":"birthMonth","type":"string","docValues":"true"}}'
curl --url $addr --request POST --header 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"true","name":"birthday","type":"string","docValues":"true"}}'
curl --url $addr --request POST --header 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"true","name":"continent","type":"text_general"}}'
curl --url $addr --request POST --header 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"true","name":"country","type":"string","docValues":"true"}}'
curl --url $addr --request POST --header 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"true","name":"dob","type":"text_general"}}'
curl --url $addr --request POST --header 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"true","name":"domain","type":"text_general"}}'
curl --url $addr --request POST --header 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"true","name":"emails","type":"text_general"}}'
curl --url $addr --request POST --header 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"true","name":"ethnicity","type":"string","docValues":"true"}}'
curl --url $addr --request POST --header 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"true","name":"firstName","type":"text_general","uninvertible":"true"}}'
curl --url $addr --request POST --header 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"true","name":"middleName","type":"text_general","uninvertible":"true"}}'
curl --url $addr --request POST --header 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"true","name":"gender","type":"string","docValues":"true"}}'
curl --url $addr --request POST --header 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"true","uninvertible":"true","name":"ips","type":"string","multiValued":"true","omitNorms":"true","omitTermFreqAndPositions":"true","sortMissingLast":"true"}}'
curl --url $addr --request POST --header 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"true","name":"lastName","type":"text_general","uninvertible":"true"}}'
curl --url $addr --request POST --header 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"true","uninvertible":"true","name":"latLong","type":"location","docValues":"true"}}'
curl --url $addr --request POST --header 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"true","uninvertible":"true","name":"location","type":"text_general"}}'
curl --url $addr --request POST --header 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"true","name":"phoneNumbers","type":"text_general"}}'
curl --url $addr --request POST --header 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"true","name":"usernames","type":"text_general","uninvertible":"true"}}'
curl --url $addr --request POST --header 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"true","name":"vin","type":"text_general","uninvertible":"true"}}'
curl --url $addr --request POST --header 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"true","name":"zipCode","type":"string","uninvertible":"true"}}'
curl --url $addr --request POST --header 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"true","name":"VRN","type":"text_general","uninvertible":"true"}}'
curl --url $addr --request POST --header 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"true","uninvertible":"false","name":"accuracy_radius","type":"pint"}}'
curl --url $addr --request POST --header 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"true","uninvertible":"false","name":"address","type":"text_general"}}'
curl --url $addr --request POST --header 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"true","uninvertible":"false","name":"asnOrg","type":"text_general"}}'
curl --url $addr --request POST --header 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"true","uninvertible":"false","name":"autoBody","type":"string"}}'
curl --url $addr --request POST --header 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"true","uninvertible":"false","name":"autoClass","type":"string"}}'
curl --url $addr --request POST --header 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"true","uninvertible":"false","name":"autoModel","type":"string"}}'
curl --url $addr --request POST --header 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"true","uninvertible":"false","name":"autoYear","type":"string","docValues":"true"}}'
curl --url $addr --request POST --header 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"true","uninvertible":"false","name":"city","type":"text_general"}}'
curl --url $addr --request POST --header 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"true","uninvertible":"false","name":"passwords","type":"string","multiValued":"true"}}'
curl --url $addr --request POST --header 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"true","uninvertible":"false","name":"source","type":"string","docValues":"true"}}'
curl --url $addr --request POST --header 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"true","uninvertible":"false","name":"state","type":"string","docValues":"true"}}'
curl --url $addr --request POST --header 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"false","name":"income","type":"string"}}'
curl --url $addr --request POST --header 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"false","uninvertible":"false","name":"line","type":"string"}}'
curl --url $addr --request POST --header 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"false","uninvertible":"false","name":"links","type":"string","multiValued":"true"}}'
curl --url $addr --request POST --header 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"false","uninvertible":"false","name":"notes","type":"string","multiValued":"true"}}'
curl --url $addr --request POST --header 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"false","uninvertible":"false","name":"party","type":"string","multiValued":"true"}}'
curl --url $addr --request POST --header 'Accept: application/json' --data-raw '{"add-field":{"stored":"true","indexed":"false","uninvertible":"false","name":"photos","type":"string","multiValued":"true"}}'
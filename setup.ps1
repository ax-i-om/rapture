$solrHOST = Read-Host 'Solr host address [127.0.0.1]'
$solrPORT = Read-Host 'Solr port [8983]'
$solrSHARDS = Read-Host 'Solr shard count [4]'
$solrREPLIC = Read-Host 'Solr replication factor [1]'

if ($solrHOST -eq "" -or $null -eq $solrHOST) {
    $solrHOST = "127.0.0.1"
}
if ($solrPORT -eq "" -or $null -eq $solrPORT) {
    $solrPORT = "8983"
}
if ($solrSHARDS -eq "" -or $null -eq $solrSHARDS) {
    $solrSHARDS = "4"
}
if ($solrREPLIC -eq "" -or $null -eq $solrREPLIC) {
    $solrREPLIC = "1"
}

curl --url "http://${solrHOST}:${solrPORT}/solr/admin/collections?action=CREATE&name=BigData&numShards=${solrSHARDS}&replicationFactor=${solrREPLIC}&wt=json" 
curl --url "http://${solrHOST}:${solrPORT}/solr/BigData/config" -d '{"set-user-property": {"update.autoCreateFields":"false"}}'

foreach($solrFIELD in Get-Content .\fields.txt) {
    curl --url "http://${solrHOST}:${solrPORT}/solr/BigData/schema?wt=json" --request POST --header 'Accept: application/json' --data-raw $solrFIELD
}
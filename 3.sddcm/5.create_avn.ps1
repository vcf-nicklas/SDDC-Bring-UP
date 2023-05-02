#get a bearer token
Request-VCFToken -fqdn sfo-vcf01.sfo.rainpole.io -username administrator@vsphere.local -password VMware1!

#get sfo-m01-ec01 edge cluster to find id
$edgecluster = Get-VCFEdgeCluster

#string replace the REPLACECLUSTERID string with the id
(Get-Content  json-files/tpl-avn.json) | Foreach-Object {$_ -replace 'REPLACECLUSTERID', $edgecluster.id }  | Out-File  json-files/avn.json

#deploy avn
Add-VCFApplicationVirtualNetwork -json (Get-Content -Raw json-files/avn.json)

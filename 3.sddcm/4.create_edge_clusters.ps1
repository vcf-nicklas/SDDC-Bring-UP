#get a bearer token
Request-VCFToken -fqdn sfo-vcf01.sfo.rainpole.io -username administrator@vsphere.local -password VMware1!
#get the .id variable of cluster sfo-m01-cl01
$sfom01id = Get-VCFCluster -Name sfo-m01-cl01

#string replace the REPLACECLUSTERID string with the id
(Get-Content  json-files/tpl-sfo-m01-nsx-edge.json) | Foreach-Object {$_ -replace 'REPLACECLUSTERID', $sfom01id.id }  | Out-File  json-files/sfo-m01-nsx-edge.json

#deploy sfo-m01-ec01
New-VCFEdgeCluster -json json-files/sfo-m01-nsx-edge.json

#get sfo-m01-ec01 edge cluster to find id
$edgecluster = Get-VCFEdgeCluster

#string replace the REPLACECLUSTERID string with the id
(Get-Content  json-files/tpl-avn.json) | Foreach-Object {$_ -replace 'REPLACECLUSTERID', $edgecluster.id }  | Out-File  json-files/avn.json

#deploy avn
Add-VCFApplicationVirtualNetwork -json (Get-Content -Raw json-files/avn.json)

#get the .id variable of cluster sfo-w01-cl01
$sfow01id = Get-VCFCluster -Name sfo-w01-cl01

#string replace the REPLACECLUSTERID string with the id
(Get-Content  json-files/tpl-sfo-w01-nsx-edge.json) | Foreach-Object {$_ -replace 'REPLACECLUSTERID', $sfow01id.id }  | Out-File  json-files/sfo-w01-nsx-edge.json

#deploy sfo-w01-ec01
New-VCFEdgeCluster -json json-files/sfo-w01-nsx-edge.json

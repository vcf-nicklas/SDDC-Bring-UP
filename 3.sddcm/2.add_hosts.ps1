Request-VCFToken -fqdn sfo-vcf01.sfo.rainpole.io -Username administrator@vsphere.local -Password VMware1!

#get the network pool id
$npid = Get-VCFNetworkPool -name sfo-w01-np01 | select id

#replace the network pool id in the json
(Get-Content json-files/tpl-sfo-w01-hosts.json) | Foreach-Object {$_ -replace ‘NPID', $($npid.id)} | Set-Content json-files/sfo-w01-hosts-mod.json

New-VCFCommissionedHost -json json-files/sfo-w01-hosts-mod.json


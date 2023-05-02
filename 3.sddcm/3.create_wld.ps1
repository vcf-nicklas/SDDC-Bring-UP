Request-VCFToken -fqdn sfo-vcf01.sfo.rainpole.io -Username administrator@vsphere.local -Password VMware1!

#get the id of the added hosts
$host01 = Get-VCFHost -Status UNASSIGNED_USEABLE | select fqdn,id | Where {$_.fqdn -eq “sfo01-w01-esx01.sfo.rainpole.io"}
$host02 = Get-VCFHost -Status UNASSIGNED_USEABLE | select fqdn,id | Where {$_.fqdn -eq “sfo01-w01-esx02.sfo.rainpole.io"}
$host03 = Get-VCFHost -Status UNASSIGNED_USEABLE | select fqdn,id | Where {$_.fqdn -eq “sfo01-w01-esx03.sfo.rainpole.io"}
$host04 = Get-VCFHost -Status UNASSIGNED_USEABLE | select fqdn,id | Where {$_.fqdn -eq “sfo01-w01-esx04.sfo.rainpole.io"}

#replace the id in the json file
(Get-Content json-files/tpl-sfo-w01.json) | Foreach-Object {$_ -replace ‘HOSTID1', $($host01.id)} | Set-Content json-files/sfo-w01-mod.json
(Get-Content json-files/sfo-w01-mod.json) | Foreach-Object {$_ -replace ‘HOSTID2', $($host02.id)} | Set-Content json-files/sfo-w01-mod.json
(Get-Content json-files/sfo-w01-mod.json) | Foreach-Object {$_ -replace ‘HOSTID3', $($host03.id)} | Set-Content json-files/sfo-w01-mod.json
(Get-Content json-files/sfo-w01-mod.json) | Foreach-Object {$_ -replace ‘HOSTID4', $($host04.id)} | Set-Content json-files/sfo-w01-mod.json

#deploy workload domain
New-VCFWorkloadDomain -json json-files/sfo-w01-mod.json

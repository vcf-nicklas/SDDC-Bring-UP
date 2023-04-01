
vcd_header=$(curl -ksSL -D - -X POST https://172.16.15.100/cloudapi/1.0.0/sessions -H "Accept: application/json;version=37.0" -u "kjohansson@NordicLab" | egrep "X-VMWARE-VCLOUD-ACCESS-TOKEN" | awk -F ' ' '{print $2}')


#sfo01-m01-esx01
curl -ks -X POST "https://172.16.15.100/api/vApp/vm-85190e93-e4e0-46f0-8c9e-b314491aea23/power/action/powerOn" -H "Accept: application/*+xml;version=38.0.0-alpha" -H "Authorization: Bearer ${vcd_header}" > /dev/null
echo "sent power-on request to sfo01-m01-esx01.sfo.rainpole.io" 
#sfo01-m01-esx02
curl -ks -X POST "https://172.16.15.100/api/vApp/vm-5d4d5af4-0e61-4eef-9ca4-309698954dc0/power/action/powerOn" -H "Accept: application/*+xml;version=38.0.0-alpha" -H "Authorization: Bearer ${vcd_header}" > /dev/null
echo "sent power-on request to sfo01-m01-esx02.sfo.rainpole.io" 
#sfo01-m01-esx03
curl -ks -X POST "https://172.16.15.100/api/vApp/vm-62daf3ec-f03c-4a53-9cca-021d41c4bb20/power/action/powerOn" -H "Accept: application/*+xml;version=38.0.0-alpha" -H "Authorization: Bearer ${vcd_header}" > /dev/null
echo "sent power-on request to sfo01-m01-esx03.sfo.rainpole.io" 
#sfo01-m01-esx04
curl -ks -X POST "https://172.16.15.100/api/vApp/vm-708a9a12-9564-4714-913c-71c18200559d/power/action/powerOn" -H "Accept: application/*+xml;version=38.0.0-alpha" -H "Authorization: Bearer ${vcd_header}" > /dev/null
echo "sent power-on request to sfo01-m01-esx04.sfo.rainpole.io" 

#sfo01-w01-esx01
curl -ks -X POST "https://172.16.15.100/api/vApp/vm-d2ba402b-ca2a-46e7-9587-92763b7d08bb/power/action/powerOn" -H "Accept: application/*+xml;version=38.0.0-alpha" -H "Authorization: Bearer ${vcd_header}" > /dev/null
echo "sent power-on request to sfo01-w01-esx01.sfo.rainpole.io" 
#sfo01-w01-esx02
curl -ks -X POST "https://172.16.15.100/api/vApp/vm-7115fce2-2a9b-46e7-b499-bf2860f6aa2b/power/action/powerOn" -H "Accept: application/*+xml;version=38.0.0-alpha" -H "Authorization: Bearer ${vcd_header}" > /dev/null
echo "sent power-on request to sfo01-w01-esx02.sfo.rainpole.io" 
#sfo01-w01-esx03
curl -ks -X POST "https://172.16.15.100/api/vApp/vm-1da7e6d3-b89e-4d40-9680-b43b9305f057/power/action/powerOn" -H "Accept: application/*+xml;version=38.0.0-alpha" -H "Authorization: Bearer ${vcd_header}" > /dev/null
echo "sent power-on request to sfo01-w01-esx03.sfo.rainpole.io" 
#sfo01-w01-esx04
curl -ks -X POST "https://172.16.15.100/api/vApp/vm-7e0c3375-621a-46bb-8c98-c65732662b5f/power/action/powerOn" -H "Accept: application/*+xml;version=38.0.0-alpha" -H "Authorization: Bearer ${vcd_header}" > /dev/null
echo "sent power-on request to sfo01-w01-esx04.sfo.rainpole.io" 

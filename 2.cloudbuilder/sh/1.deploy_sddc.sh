curl 'https://sfo-cb01.rainpole.local/v1/sddcs' -i -u 'admin:VMware1!VMware1!' -X POST \
    -H 'Content-Type: application/json' \
    -H 'Accept: application/json' \
    -d @../json-files/vcf-ems.json

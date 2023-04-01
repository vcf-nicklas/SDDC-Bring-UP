#sfo-m01 hosts
curl --header "Content-Type: application/json" \
  --user admin:VMware1! https://go-via.rainpole.io:8443/v1/addresses \
  --insecure \
  --request POST \
  --data '{ "domain": "sfo.rainpole.io", 
            "group_id": 1, 
            "hostname": "sfo01-m01-esx01", 
            "ip": "10.16.11.101", 
            "mac": "00:50:56:01:08:78", 
            "pool_id": 1, 
            "progress": 0, 
            "progresstext": "", 
            "reimage": true }'

curl --header "Content-Type: application/json" \
  --user admin:VMware1! https://go-via.rainpole.io:8443/v1/addresses \
  --insecure \
  --request POST \
  --data '{ "domain": "sfo.rainpole.io", 
            "group_id": 1, 
            "hostname": "sfo01-m01-esx02", 
            "ip": "10.16.11.102", 
            "mac": "00:50:56:01:08:6a", 
            "pool_id": 1, 
            "progress": 0, 
            "progresstext": "", 
            "reimage": true }'

curl --header "Content-Type: application/json" \
  --user admin:VMware1! https://go-via.rainpole.io:8443/v1/addresses \
  --insecure \
  --request POST \
  --data '{ "domain": "sfo.rainpole.io", 
            "group_id": 1, 
            "hostname": "sfo01-m01-esx03", 
            "ip": "10.16.11.103", 
            "mac": "00:50:56:01:08:7e", 
            "pool_id": 1, 
            "progress": 0, 
            "progresstext": "", 
            "reimage": true }'

curl --header "Content-Type: application/json" \
  --user admin:VMware1! https://go-via.rainpole.io:8443/v1/addresses \
  --insecure \
  --request POST \
  --data '{ "domain": "sfo.rainpole.io", 
            "group_id": 1, 
            "hostname": "sfo01-m01-esx04", 
            "ip": "10.16.11.104", 
            "mac": "00:50:56:01:08:61", 
            "pool_id": 1, 
            "progress": 0, 
            "progresstext": "", 
            "reimage": true }'

#sfo-w01 hosts

curl --header "Content-Type: application/json" \
  --user admin:VMware1! https://go-via.rainpole.io:8443/v1/addresses \
  --insecure \
  --request POST \
  --data '{ "domain": "sfo.rainpole.io", 
            "group_id": 2, 
            "hostname": "sfo01-w01-esx01", 
            "ip": "10.16.31.101", 
            "mac": "00:50:56:01:08:7c", 
            "pool_id": 2, 
            "progress": 0, 
            "progresstext": "", 
            "reimage": true }'

curl --header "Content-Type: application/json" \
  --user admin:VMware1! https://go-via.rainpole.io:8443/v1/addresses \
  --insecure \
  --request POST \
  --data '{ "domain": "sfo.rainpole.io", 
            "group_id": 2, 
            "hostname": "sfo01-w01-esx02", 
            "ip": "10.16.31.102", 
            "mac": "00:50:56:01:08:82", 
            "pool_id": 2, 
            "progress": 0, 
            "progresstext": "", 
            "reimage": true }'

curl --header "Content-Type: application/json" \
  --user admin:VMware1! https://go-via.rainpole.io:8443/v1/addresses \
  --insecure \
  --request POST \
  --data '{ "domain": "sfo.rainpole.io", 
            "group_id": 2, 
            "hostname": "sfo01-w01-esx03", 
            "ip": "10.16.31.103", 
            "mac": "00:50:56:01:08:84", 
            "pool_id": 2, 
            "progress": 0, 
            "progresstext": "", 
            "reimage": true }'

curl --header "Content-Type: application/json" \
  --user admin:VMware1! https://go-via.rainpole.io:8443/v1/addresses \
  --insecure \
  --request POST \
  --data '{ "domain": "sfo.rainpole.io", 
            "group_id": 2, 
            "hostname": "sfo01-w01-esx04", 
            "ip": "10.16.31.104", 
            "mac": "00:50:56:01:08:86", 
            "pool_id": 2, 
            "progress": 0, 
            "progresstext": "", 
            "reimage": true }'


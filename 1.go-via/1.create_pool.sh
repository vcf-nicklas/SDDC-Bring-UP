#create management pool
curl --header "Content-Type: application/json" \
  --user admin:VMware1! https://172.16.1.3:8443/v1/pools \
  --insecure \
  --request POST \
  --data '{
    "name": "sfo-m01-az01",
    "net_address": "10.16.11.0",
    "netmask": 24,
    "start_address": "10.16.11.101",
    "end_address": "10.16.11.104",
    "gateway": "10.16.11.1",
    "lease_time": 7200
    }'

#create workload pool
curl --header "Content-Type: application/json" \
  --user admin:VMware1! https://172.16.1.3:8443/v1/pools \
  --insecure \
  --request POST \
  --data '{
    "name": "sfo-w01-az01",
    "net_address": "10.16.31.0",
    "netmask": 24,
    "start_address": "10.16.31.101",
    "end_address": "10.16.31.104",
    "gateway": "10.16.31.1",
    "lease_time": 7200
    }'


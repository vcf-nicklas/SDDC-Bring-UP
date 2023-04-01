#create management group
curl --header "Content-Type: application/json" \
  --user admin:VMware1! https://go-via.rainpole.io:8443/v1/groups \
  --insecure \
  --request POST \
  --data '{ "image_id": 1, 
            "name": "sfo-m01-az01", 
            "password": "VMware1!", 
            "pool_id": 1,
            "dns": "10.16.11.4,10.16.11.5",
            "ntp": "10.16.11.4,10.16.11.5",
            "options": {
              "ssh": true,
              "certificate": true
            }
          }'

#create workload group
curl --header "Content-Type: application/json" \
  --user admin:VMware1! https://go-via.rainpole.io:8443/v1/groups \
  --insecure \
  --request POST \
  --data '{ "image_id": 1, 
            "name": "sfo-w01-az01", 
            "password": "VMware1!", 
            "pool_id": 2,
            "dns": "10.16.11.4,10.16.11.5",
            "ntp": "10.16.11.4,10.16.11.5",
            "options": {
              "ssh": true,
              "certificate": true
            }
          }'

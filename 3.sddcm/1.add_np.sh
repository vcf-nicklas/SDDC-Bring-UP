curl 'https://sfo-vcf01.rainpole.io/v1/network-pools' -i -X POST \
    -H 'Content-Type: application/json' \
    -H 'Authorization: Bearer etYWRta....' \
    -d '{
	"name": "sfo-w01-np01",
	"networks": [
		{
			"type": "VSAN",
			"vlanId": 1633,
			"mtu": 9000,
			"subnet": "172.16.33.0",
			"mask": "255.255.255.0",
			"gateway": "172.16.33.1",
			"ipPools": [
				{
					"start": "172.16.33.101",
					"end": "172.16.33.104"
				}
			]
		},
		{
			"type": "VMOTION",
			"vlanId": 1632,
			"mtu": 9000,
			"subnet": "172.16.32.0",
			"mask": "255.255.255.0",
			"gateway": "172.16.32.1",
			"ipPools": [
				{
					"start": "172.16.32.101",
					"end": "172.16.32.104"
				}
			]
		}
	]
}
'
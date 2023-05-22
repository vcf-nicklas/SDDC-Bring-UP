###############################################
# NSX Overlay Segments
# Configure below according to your environment
###############################################
$skipcertcheck = $true
$AuthMethod = “Basic”
$NSXMgr=”sfo-w01-nsx01.sfo.rainpole.io”
$apiendpoint = "/policy/api/v1/infra/segments/"
$base_url = ("https://" + $NSXMgr + $apiendpoint)
$dhcp_server_path = "/infra/dhcp-server-configs/"
$dhcp_gateway_path = "/infra/tier-1s/"
$transport_zone_path = "/infra/sites/default/enforcement-points/default/transport-zones/"
$CSVDIR = "C:\Users\adm-hoffmanma\Documents\GitHub\vmware\area51\v1.0\Script_config"
$CREDDIR = "C:\Users\adm-hoffmanma\Documents\GitHub\vmware\area51\v1.0\Script"
$SCRIPT_CONFIG_FILE = "2-overlay-segments.csv"

###############################################
# Nothing to configure below this line
###############################################

###############################################
# Verifying NSX credentials
###############################################
# Setting NSX credentials XML
$NSXCredentialsFile = $CREDDIR + "NSXCredentials.xml"
# Testing if XML file exists
$NSXCredentialsFileTest = Test-Path $NSXCredentialsFile
# IF doesn't exist, prompt and save credentials in XML
IF ($NSXCredentialsFileTest -eq $False)
{
$NSXCredentials = Get-Credential -Message "Enter NSX credentials"
$NSXCredentials | EXPORT-CLIXML $NSXCredentialsFile -Force
}
# Importing credentials
$NSXCredentials = IMPORT-CLIXML $NSXCredentialsFile

###############################################
# Create NSX Overlay Segments
###############################################
# Importing segment configs

$segment_config = Import-CSV ($CSVDIR + $SCRIPT_CONFIG_FILE)

# Create profiles
Foreach ($seg in $segment_config)
{
    $display_name = $seg.DisplayName
    $gw_address = $seg.GWAddress
    $dhcp_range = $seg.DHCPRange
    $server_address = $seg.ServerAddress
    $dns_servers = $seg.DNSServers
    $network = $seg.Network
    $dhcp_server_id = $seg.DHCPServerID
    $lt = $seg.LeaseTime
    $gateway_id = $seg.GatewayID
    $resource_type = $seg.ResourceType
    $transportzone_id = $seg.TransportZoneID
    $dhcpserverpath = ($dhcp_server_path + $dhcp_server_id)
    $dhcpgatewaypath = ($dhcp_gateway_path + $gateway_id)
    $transportzonepath = ($transport_zone_path + $transportzone_id)
    $JSON = "
    {
    `"display_name`":`"$display_name`",
    `"subnets`": [
      {
        `"gateway_address`": `"$gw_address`",
        `"dhcp_ranges`": [ `"$dhcp_range`" ],
        `"dhcp_config`": {
            `"resource_type`": `"$resource_type`",
            `"server_address`": `"$server_address`",
            `"lease_time`": `"$lt`",
            `"dns_servers`": [`"$dns_servers`"]
      },
      `"network`": `"$network`"
      }
    ],
    `"dhcp_config_path`": `"$dhcpserverpath`",
    `"connectivity_path`": `"$dhcpgatewaypath`"  }
    `"transport_zone_path`": `"$transportzonepath`"  }
    
"
    Invoke-restmethod -Uri ($base_url + $display_name) -Method PATCH -Body $JSON -ContentType 'application/json' -Credential $NSXCredentials -SkipCertificateCheck:$skipcertcheck -Authentication:$AuthMethod
    Write-Host "Overlay segment $display_name created"
}
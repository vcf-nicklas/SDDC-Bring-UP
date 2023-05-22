###############################################
# DHCP Profiles
# Configure below according to your environment
###############################################
$skipcertcheck = $true
$AuthMethod = “Basic”
$NSXMgr=”sfo-w01-nsx01.sfo.rainpole.io”
$apiendpoint = "/policy/api/v1/infra/dhcp-server-configs/"
$base_url = ("https://" + $NSXMgr + $apiendpoint)
$edgeclusterpath = "/infra/sites/default/enforcement-points/default/edge-clusters/d5792b0e-3875-4b70-8a47-5cdad59fb5a9"
$CSVDIR = "C:\Users\adm-hoffmanma\Documents\GitHub\vmware\area51\v1.0\Script_config"
$CREDDIR = "C:\Users\adm-hoffmanma\Documents\GitHub\vmware\area51\v1.0\Script"
$SCRIPT_CONFIG_FILE = "1-dhcp-profiles.csv"

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
# Create DHCP Profiles
###############################################
# Importing DHCP profile configs
$dhcpprofile = Import-CSV ($CSVDIR + $SCRIPT_CONFIG_FILE)
$dhcpprofile | Format-Table -AutoSize

# Create profiles
Foreach ($dhcp in $dhcpprofile)
{
    $dhcpname = $dhcp.Name
    $server_address = $dhcp.IPAddress
    $lt = $dhcp.LeaseTime
    $JSON = "
    {
        `"server_address`": `"$server_address`",
        `"edge_cluster_path`": `"$edgeclusterpath`",
        `"lease_time`": `"$lt`"
      }
    "
    Invoke-restmethod -Uri ($base_url + $dhcpname) -Method PATCH -Body $JSON -ContentType 'application/json' -Credential $NSXCredentials -SkipCertificateCheck:$skipcertcheck -Authentication:$AuthMethod
    Write-Host "DHCP profile $dhcpname created"
    }
    
    
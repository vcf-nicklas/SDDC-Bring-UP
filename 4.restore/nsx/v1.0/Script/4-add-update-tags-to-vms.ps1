###############################################
# Tag VM(s) with new or existing tag
# This script requires PowerCLI
# Configure below according to your environment
###############################################
$vcenter = ”sfo-w01-vc01.sfo.rainpole.io”
$skipcertcheck = $true
$AuthMethod = “Basic”
$NSXMgr = ”sfo-w01-nsx01.sfo.rainpole.io”
$apiendpoint = "/api/v1/fabric"
$base_url = ("https://" + $NSXMgr + $apiendpoint)
$CSVDIR = "C:\Users\adm-hoffmanma\Documents\GitHub\vmware\area51\v1.0\Script_config"
$CREDDIR = "C:\Users\adm-hoffmanma\Documents\GitHub\vmware\area51\v1.0\Script"
$SCRIPT_CONFIG_FILE = "4-add-updatetags-to-vms.csv"
$NEW_SCRIPT_CONFIG_FILE = "4-add-updatetags-to-vmsid.csv"

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
# Verifying vCenter credentials
###############################################
# Setting vCenter credentials file
$VCCredentialsFile = $CREDDIR + "VCCredentials.xml"
# Testing if file exists
$VCCredentialsFileTest =  Test-Path $VCCredentialsFile
# IF doesn't exist, prompt and save credentials
IF ($VCCredentialsFileTest -eq $False)
{
$VCCredentials = Get-Credential -Message "Enter vCenter credentials"
$VCCredentials | EXPORT-CLIXML $VCCredentialsFile -Force
}
# Importing credentials
$VCCredentials = IMPORT-CLIXML $VCCredentialsFile

###############################################
# Connect vCenter Server
###############################################
Connect-VIServer -Server $vcenter -Credential $VCCredentials

###############################################
# Add & Update Tags
###############################################
# Create new CSV with VMID
$vmlist = import-csv ($CSVDIR + $SCRIPT_CONFIG_FILE)
foreach ($vmname in $vmlist) {
    $displayName = $vmname.VMName
    $VMID = Get-VM -Name $displayName | Get-View -Property "Config"
    $vmlist += Add-Member -InputObject $vmname -NotePropertyName VMID -NotePropertyValue $VMID.Config.InstanceUuid
}
$vmlist | Export-Csv ($CSVDIR + $NEW_SCRIPT_CONFIG_FILE) -notypeinformation

Start-Sleep -Seconds 5

# Add and update tags from CSV
$taglist = Import-CSV ($CSVDIR + $NEW_SCRIPT_CONFIG_FILE)
$endpoint = "/virtual-machines"
$action = "add_tags"
Foreach ($tagmember in $taglist)
{
    $memberid = $tagmember.VMID
    $member = $tagmember.VMName
    $tag = $tagmember.Tag
    $scope = $tagmember.Scope

    $JSON = "
    {
        `"external_id`":`"$memberid`",
        `"tags`": [
            {
                `"scope`":`"$scope`",
                `"tag`":`"$tag`"
            }
            ]
    }
    "

    Invoke-restmethod -Uri ($base_url + $EndPoint + "?action=" + $action) -Method POST -Body $JSON -ContentType 'application/json' -Credential $NSXCredentials -SkipCertificateCheck:$skipcertcheck -Authentication:$AuthMethod
    Write-Host "$member tagged with $scope | $tag"
}

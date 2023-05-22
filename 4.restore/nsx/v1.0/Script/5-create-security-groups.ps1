###############################################
# Create Security Groups
# Configure below according to your environment
###############################################
$skipcertcheck = $true
$AuthMethod = “Basic”
$NSXMgr=”sfo-w01-nsx01.sfo.rainpole.io”
$apiendpoint = "/policy/api/v1/infra/domains/default/groups/"
$base_url = ("https://" + $NSXMgr + $apiendpoint)
$CSVDIR = "C:\Users\adm-hoffmanma\Documents\GitHub\vmware\area51\v1.0\Script_config"
$CREDDIR = "C:\Users\adm-hoffmanma\Documents\GitHub\vmware\area51\v1.0\Script"
$SCRIPT_CONFIG_FILE = "5-security-groups.csv"

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
# Security Groups
###############################################
# Create Security Groups from CSV
$security_group = Import-CSV ($CSVDIR + $SCRIPT_CONFIG_FILE)
Foreach ($sg in $security_group)
{
    $membertype = $sg.Type
    $value = $sg.Value
    $key = $sg.Key
    $operator = $sg.Operator
    $resource_type = $sg.ResourceType
    $description = $sg.Description
    $displayname = $sg.DisplayName

    $JSON = "
    {
      `"expression`": [
        {
          `"member_type`": `"$membertype`",
          `"value`": `"$value`",
          `"key`": `"$key`",
          `"operator`": `"$operator`",
          `"resource_type`": `"$resource_type`"
        }
      ],
      `"description`": `"$description`",
      `"display_name`": `"$displayname`"
  }
  "
    Invoke-restmethod -Uri ($base_url + $displayname) -Method PATCH -Body $JSON -ContentType 'application/json' -Credential $NSXCredentials -SkipCertificateCheck:$skipcertcheck -Authentication:$AuthMethod
    Write-Host "Security group $displayname created"
}
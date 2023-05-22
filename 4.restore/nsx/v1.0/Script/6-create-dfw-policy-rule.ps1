###############################################
# Create DFW Policy and Rules
# Configure below according to your environment
###############################################
$skipcertcheck = $true
$AuthMethod = “Basic”
$NSXMgr=”sfo-w01-nsx01.sfo.rainpole.io”
$apiendpoint = "/policy/api/v1/infra/domains/default/security-policies/"
$base_url = ("https://" + $NSXMgr + $apiendpoint)
$CSVDIR = "C:\Users\adm-hoffmanma\Documents\GitHub\vmware\area51\v1.0\Script_config"
$CREDDIR = "C:\Users\adm-hoffmanma\Documents\GitHub\vmware\area51\v1.0\Script"
$SCRIPT_CONFIG_FILE = "6-dfw-policy-rule.csv"

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
# DFW
###############################################
# Create DFW Policy and Rules from CSV
$dfw_config = Import-CSV ($CSVDIR + $SCRIPT_CONFIG_FILE)
Foreach ($dfw in $dfw_config)
{
    $policy_display_name = $dfw.PolicyDisplayName
    $policy_category = $dfw.Category
    $policy_sequence = $dfw.Sequence
    $rule_display_name = $dfw.RuleDisplayName
    $rule_source = $dfw.Source
    $rule_destination = $dfw.Destination
    $rule_services = $dfw.Services
    $rule_action = $dfw.action

    $JSON = "
    {
      `"display_name`": `"$policy_display_name`",
      `"category`": `"$policy_category`",
      `"rules`": [
        {
          `"display_name`": `"$rule_display_name`",
          `"sequence_number`": `"$policy_sequence`",
          `"source_groups`": [
            `"$rule_source`"
          ],
          `"destination_groups`": [
            `"$rule_destination`"
          ],
          `"services`": [
            `"$rule_services`"
          ],
          `"action`": `"$rule_action`"
        } 
      ]
  }
  "
    Invoke-restmethod -Uri ($base_url + $policy_display_name) -Method PATCH -Body $JSON -ContentType 'application/json' -Credential $NSXCredentials -SkipCertificateCheck:$skipcertcheck -Authentication:$AuthMethod
    Write-Host "DFW Policy $policy_display_name created"
}
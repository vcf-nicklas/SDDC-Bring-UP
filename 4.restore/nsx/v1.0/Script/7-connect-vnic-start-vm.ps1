###############################################
# Create and connect vNIC to VM
# This script requires PowerCLI
# Configure below according to your environment
###############################################
$vcenter = ”sfo-w01-vc01.sfo.rainpole.io”
$CSVDIR = "C:\Users\adm-hoffmanma\Documents\GitHub\vmware\area51\v1.0\Script_config"
$CREDDIR = "C:\Users\adm-hoffmanma\Documents\GitHub\vmware\area51\v1.0\Script"
$SCRIPT_CONFIG_FILE = "7-area51-vms.csv"

###############################################
# Nothing to configure below this line
###############################################

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
# Connect vNIC & Start VMs
###############################################
# Connect vNICs from CSV
$area51_vms = Import-CSV ($CSVDIR + $SCRIPT_CONFIG_FILE)
Foreach ($vm in $area51_vms)
{
    $vmname = $vm.VMName
    $vdpg = $vm.VDPortgroup
    $type = $vm.Type

    New-NetworkAdapter -VM $vmname -Portgroup $vdpg -StartConnected -Type $type

}

read-host “Press ENTER to start VMs”

#Start VMs from CSV
$area51_vms = Import-CSV $VMCSV

Foreach ($vm in $area51_vms)
{
    $vmname = $vm.VMName

    Start-VM -VM $vmname -Confirm:$false

}
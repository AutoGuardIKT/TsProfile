# Get all users TsProfile path 
$Results = Get-ADUser -Filter * | Select DistinguishedName,SamAccountName,GivenName,Surname,`
    @{Name="TsProfile";Expression={([adsi]("LDAP://$($_.DistinguishedName)")).psbase.InvokeGet("terminalservicesprofilepath")}}

$TsProfile = $Results | Where-Object TsProfile
$TsProfile | ft

Write-Output "Exit script (Ctrl-C) now if you do not want to remove all of the above profilepaths"
pause
# Set all TsProfile paths to ""
Foreach ($user in $TsProfile) {
    $ADUser = [ADSI]"LDAP://$($user.DistinguishedName)"
    $ADUser.psbase.InvokeSet("terminalservicesprofilepath","")
    $ADuser.setinfo()

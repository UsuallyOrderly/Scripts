#testing
#Grab service accounts on all servers
$servers = Get-ADComputer -Filter * -Property Name,OperatingSystem | Where-Object {$_.OperatingSystem -like "*server*"} | select name -ExpandProperty name

Foreach ($s in $servers){
    Get-WmiObject win32_service -computername $s | Select-Object systemname,name,startname,state | Export-Csv $name-services.txt -NoTypeInformation
}

#Grab Server version & GUI presence for all servers
$servers = Get-ADComputer -Filter * -Property Name,OperatingSystem | Where-Object {$_.OperatingSystem -like "*server*"} | select name -ExpandProperty name
$output = @()

foreach ($s in $servers) {
    $os = Get-WmiObject win32_operatingsystem -ComputerName $s
    $gui = Get-WMIObject win32_optionalfeature -computer $s | where Name -eq 'Server-Gui-Shell' #| Select InstallState # 1 = GUI, 2 = CORE

    $output += [pscustomobject]@{
        'ComputerName' = $s
        'OS Version' = $os.caption
        'Service Pack' = $os.ServicePackMajorVersion
        'InstallState' = (&{ if( $gui.installstate -eq '1') { "GUI" } else { "Core" } } )
    }
}
$output #| Out-GridView
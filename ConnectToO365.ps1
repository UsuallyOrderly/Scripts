   #Get O365 Credential
   $Office365Credential = Get-Credential
   
   #region Connect to Office 365
    Write-Verbose "Connecting to office 365 Configuration Microsoft.Exchange"
    $Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $Office365Credential -Authentication Basic -AllowRedirection
    Import-PSSession $Session | Out-Null
    Connect-MSolService –Credential $Office365Credential | Out-Null
    #endregion Connect to Office 365
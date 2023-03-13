# Self-elevate the script if required
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
  if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
    $CommandLine = "-NoExit -File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
    Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
    Exit
  }
}

$action = New-ScheduledTaskAction -Execute 'bingwallpaper-cli.exe'
$trigger = New-ScheduledTaskTrigger -SETTING -At 7am
Register-ScheduledTask -Action $action -Trigger $trigger -TaskPath "Chezmoi" -TaskName "Update Bing Wallpaper" -Description "Retrieves the latest Bing wallpaper and set it as Desktop background."

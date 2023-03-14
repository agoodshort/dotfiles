$action = New-ScheduledTaskAction -Execute 'bingwallpaper-cli.exe'
$trigger = New-ScheduledTaskTrigger -SETTING -At 7am
Register-ScheduledTask -Action $action -Trigger $trigger -TaskPath "Chezmoi" -TaskName "Update Bing Wallpaper" -Description "Retrieves the latest Bing wallpaper and set it as Desktop background."

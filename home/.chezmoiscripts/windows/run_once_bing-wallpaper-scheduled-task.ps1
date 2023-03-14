$action = New-ScheduledTaskAction -Execute '%userprofile%\scoop\shims\bingwallpaper-cli.exe'
$trigger = New-ScheduledTaskTrigger -Daily -At 10am
Register-ScheduledTask -Action $action -Trigger $trigger -TaskPath "Chezmoi" -TaskName "Update Bing Wallpaper" -Description "Retrieves the latest Bing wallpaper and set it as Desktop background."

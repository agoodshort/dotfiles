Invoke-Expression (&starship init powershell)
$Env:KOMOREBI_CONFIG_HOME = "$Env:USERPROFILE\.config\komorebi"

$SourceScoop = (Get-Command scoop).Source

function scoop
{
    if ($args[0] -eq "install")
    {
        Invoke-Expression $SourceScoop $args
    } else
    {
        Invoke-Expression -Command "&$SourceScoop $args"
    }
}

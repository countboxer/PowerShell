# FUNCTIONS and ALIASES

# Create an empty file
function touch_file {new-item $args[0] -itemtype file}
New-Alias -name touch -value touch_file

# Change directory to my home directory
function go_home {push-location -path $HOME}
New-Alias -name pushh -value go_home

# List the locations on my stack
function location_list {get-location -stack}
New-Alias -name getl	-value location_list
New-Alias -name list	-value Get-ChildItem
New-Alias -name notepad	-value "C:\Program Files (x86)\Notepad++\notepad++.exe"
New-Alias -name now		-value get-date 

# USER INTERFACE
$Host.UI.RawUI.WindowTitle = "Jeff Belknap - running as Admin"
function prompt {"" + $(get-location) + ">>"}

#Sometimes I want to type 'powershell' in the file explorer window to go the directory I am in
#set-location c:\Users\jczbe6\Desktop

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

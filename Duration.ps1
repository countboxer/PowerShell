$StartDate = (GET-DATE)
$EndDate = [datetime]"01/07/2019 08:00 AM"
$Duration = ($EndDate - $StartDate)
Write-Host([string]::Format("The duration between now and the end is {0}",$Duration))
Write-Host([string]::Format("The number of days remaining is {0}", $Duration.Days))
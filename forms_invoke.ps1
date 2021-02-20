<#
.SYNOPSIS
Calls a forms URL to process forms files

.DESCRIPTION
This script is used in scheduled jobs to perform various processing functions

.PARAMETER proc_type
This is the type of processing to be done. The only valid values are 'distribute', 'import' or 'purge'

.EXAMPLE
powershell Get-Help ./forms_invoke.ps1 -full

.EXAMPLE
powershell ./forms_invoke.ps1 -proc_type distribute

<No output is returned from successfull execution of the script.>
#>

Param(
	[Parameter(Mandatory=$true, HelpMessage="A process type of distribute, import or purge is required!")]
	[ValidateSet("distribute", "import", "purge")]
	[string]$proc_type
)

<#
.DESCRIPTION
This code validates the process type, builds the URL to be called and then calls it. No output is returned from the request.
#>
try {
	if ('distribute','import','purge' -NotContains $proc_type) {
		"An invalid processing type was submitted! Please run the Get-Help example and review the syntax and parameter sections."
	} else {
		$proc_url = "https://here.there.com/FMT/" + $proc_type
		$proc_url
		#Invoke-WebRequest -URI $proc_url
	}
}
catch [System.Management.Automation.ParameterBindingException] {
	throw "Missing argument exception"
}

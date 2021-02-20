<#
.SYNOPSIS
Displays the type and value of parameters passed in from the command line.

.DESCRIPTION
This is a test script used to display the type and value of various parameters passed in via the command line. It prints the data type and value of the parameter in a user friendly manner. It also expands any array parameters by displaying each value on a separate line.

.PARAMETER param_string
This is a string type parameter. [-param_string 'This is a value for a string parameter']
.PARAMETER param_char
This is a character type parameter. [-param_char 'p']
.PARAMETER param_int
This is an integer type parameter. [-param_int 42]
.PARAMETER param_bool
This is a boolean type parameter. [-param_bool $True]
.PARAMETER param_date
This is a date time type parameter. [-param_date '4/30/1961 08:45:34']
.PARAMETER param_array
This is an array type parameter. [-param_array 'first', 'second', 'third']

.EXAMPLE
powershell Get-Help ./param_list.ps1 -full

.EXAMPLE
powershell ./param_list.ps1 -param_string 'This is a value for a string parameter' -param_char 'p' -param_int 42 -param_bool $True -param_date '4/30/1961 08:45:34' -param_array 'first', 'second', 'third'

The string parameter is "This is a value for a string parameter"
The character parameter is 'p'
The integer parameter is 42
The boolean parameter is True
The datetime parameter is 4/30/1961 8:45:34 AM
The values in the array parameter are
		0 - first
		1 - second
		2 - third
.EXAMPLE
powershell ./param_list.ps1

The string parameter is ""
The character parameter is '~'
The integer parameter is 1
The boolean parameter is False
The datetime parameter is 6/10/2019 12:40:42 PM
The array parameter has a null value
#>

param(
	[string]$param_string,
	[char]$param_char="~",
	[int]$param_int=1,
	[bool]$param_bool,
	[datetime]$param_date=(Get-Date),
	[array]$param_array
)

<#
.DESCRIPTION
This function takes a parameter type (i.e. string ) and a parameter value and displays the parameter information in a user-friendly manner.
If the parameter type is an object the Show-Array function is called to parse the object into its component parts.
#>
function Show-Parameters($ParamName, $ParamValue) {
	#$ParamValue.GetType().Name
	switch ($ParamValue.GetType().Name) {
		'String' {"`tThe {0} parameter is ""{1}""" -f $ParamName, $ParamValue}
		'Char' {"`tThe {0} parameter is '{1}'" -f $ParamName, $ParamValue}
		'Object[]' {Show-Array($ParamValue)}
		Default {"`tThe {0} parameter is {1}" -f $ParamName, $ParamValue}
	}
}

<#
.DESCRIPTION
This function takes an array parameter and displays each array entry on its own line. The foreach approach doesn't return a counter while the for approach does.
#>
function Show-Array($ParamArray) {
	<#
	foreach ($i in $ParamArray) {
		$i
	}
	#>
	"`tThe values in the array parameter are"
	for ($pos = 0; $pos -lt $ParamArray.Length; $pos++) {
		"`t`t{0} -> {1}" -f $pos, $ParamArray[$pos]
	}
}

"`nThis shows only parameters from the command line:"
foreach($boundparam in $PSBoundParameters.GetEnumerator()) {
	"`tType={0}`tKey={1}`tValue={2}" -f $boundparam.Value.GetType().Name, $boundparam.Key,$boundparam.Value
}

"`nThis shows all parameters even if they are not on the command line:"
Show-Parameters 'string' $param_string
Show-Parameters 'character' $param_char
Show-Parameters 'integer' $param_int
Show-Parameters 'boolean' $param_bool
Show-Parameters 'datetime' $param_date
if ($null -eq $param_array) {
	"The array parameter has a null value"
} else {
	Show-Parameters 'array' $param_array
}

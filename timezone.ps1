$request = 'http://worldtimeapi.org/api/timezone/Europe/Dublin'
$data = Invoke-WebRequest $request | ConvertFrom-Json
$x = $data.datetime
'The current JSON value is [ {0} ] with a type of [ {1} ]' -f $x, $x.GetType().Name

$y = ([DateTimeOffset] $x).ToString("f")
'The current date and time in Dublin, Ireland is {0}' -f $y
'The type of the reformatted datetime is [ {0} ]' -f $y.GetType().Name

'The current local date and time is: {0}' -f (Get-Date -Format f)

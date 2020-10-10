#Requires -Version 4

<#		
.EXAMPLE
	PS> Get-MyScheduledTask.ps1 | Where-Object {$_.CreationDate -lt (Get-Date).AddDays(-1)}

	This example will find all scheduled tasks that were created within the last day.
.EXAMPLE
	PS> Get-MyScheduledTask.ps1 | Where-Object {($_.Author -notmatch 'Microsoft') -and $_.Author}

	This example will find all scheduled tasks that are non-default.  It removes all scheduled tasks that have an author with
	the word 'Microsoft' in it or has a null value for the author	
#>
[CmdletBinding()]
[OutputType('Selected.Microsoft.Management.Infrastructure.CimInstance')]
param ()
process {
	try {
		Get-ScheduledTask | Select-Object TaskName,Author, @{ 'n' = 'CreationDate'; 'e' = { [datetime]$_.Date } }
	} catch {
		Write-Error "$($_.Exception.Message) - Line Number: $($_.InvocationInfo.ScriptLineNumber)"
	}
}
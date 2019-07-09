# in Github java code

[CmdletBinding()]
Param(
	[Parameter(Mandatory=$False)]
	[string]$sourceDir = "C:\Program Files\GE",
	[Parameter(Mandatory=$False)]
	[string]$buildVersion = "18.1.0"
    )

#Build the path to the application.yml file
$yaml = $sourceDir + "\Enterprise Impact " + $buildVersion + "\Core\all-svc-config\application.yml"
$yamlCopy = $sourceDir + "\Enterprise Impact " + $buildVersion + "\Core\all-svc-config\applicationcopy.yml"
$temp = $sourceDir + "\Enterprise Impact " + $buildVersion + "\Core\all-svc-config\temp.yml"
#make copy of yaml file
"backup application.yml"
Copy-Item $yaml $yamlCopy
#update YAML File
#get the content of the application.yml file
#build the match strings
$Major =   "majorVersion: \d*"
$Minor =   "releaseNumber: \d*"
$Build =   "buildNumber: \d*"
"remove version string to temp"
Get-Content $yaml | Where-Object {$_ -notmatch $Major} | Where-Object {$_ -notmatch $Minor} | Where-Object {$_ -notmatch $Build}  | set-content $temp
Copy-Item $temp $yaml
Remove-Item $temp

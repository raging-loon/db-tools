Param(
	[Parameter()]
	[Switch]$start_gui,
	[String]$controlfile,
	[String]$dbfile1,
	[String]$dbfile2,
	[String]$dbfile3,
	[String]$column,
	[String]$outputfole
)

function excel_exclusive_sort{
	Param(
		[String]$controlfile,
		[String[]]$dbfiles,
		[String]$column,
		[String]$output
	)
	$uniq_ent = @()
	$target_entries = Get-Content $controlfile
	for(($i = 0); $i -lt $dbfiles.Count; $i++){
		foreach($line in $target_entries){
			
			if(($null -eq (Import-Excel -Path $dbfiles[$i] | WHere-Object $column -eq $line)) -and $uniq_ent -notcontains $line) {
				$uniq_ent += $line;
			}	
		}
	}
	foreach($entry in $uniq_ent){
		$entry | Out-File -FilePath $output -Append
	}
}
$dbfiles = @('.\User Database Test.xlsx','.\User Database 2.xlsx')

excel_exclusive_sort -controlfile '.\control.txt' -dbfiles $dbfiles -column 'Username' -output 'output.txt'  
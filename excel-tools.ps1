

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
			if((Import-Excel -Path $dbfiles[$i] | WHere-Object $column -eq $line) -eq $null)	
		}
	}
}
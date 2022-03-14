Param(
	[Parameter()]
	[Switch]$help,
	[Switch]$start_gui,
	[String]$controlfile,
	[String]$dbfile1,
	[String]$dbfile2,
	[String]$dbfile3,
	[String]$column,
	[String]$output
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
		if($dbfiles[$i] -eq ''){
			continue
		}
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


if($help){
	Write-Host 'List of options for Excel Tools'
	Write-Host '-help - print this list'
	Write-Host '-controlfile: - file with entries for comparison'
	Write-Host '-dbfile1-3: - use dbfile1, dbfile2, etc. These are the database files to run -controlfile against'
	Write-Host '-column: - column that should be checked'
	Write-Host '-output: - Saves the results in a file of your choice'
	Write-Host '-start_gui - Start the GUI, still in development'
	Write-Host "Example: .\excel-tools.ps1 -controlfile .\control.txt -dbfile1 '.\db1.xlsx' -dbfile2 '.\User Database Test.xlsx' -output output.txt -column 'Username'"
} elseif($start_gui){
	Write-Host "GUI Still in development"
	exit
} else {
	$dbfiles = @($dbfile1, $dbfile2,$dbfile3)
	excel_exclusive_sort -controlfile $controlfile -dbfiles $dbfiles -column $column -output $output

}
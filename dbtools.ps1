# $controlfile = Get-Content "./5000-words.txt";
# $db_file = Get-Content "./5000-words.txt.bak";
# $outfile = "output.txt";


function do_exclusive_sort{
  param (
    [String]$controlfile,
    [String[]]$dbfiles,
    [String]$output
  )
  Write-Host $dbfiles
  for(($i = 0); $i -lt $dbfiles.Count; $i++){
    Write-host $dbfiles[$i];
  }
}
$dbarray = @('./db1.txt','./db2.txt')

do_exclusive_sort -ParameterName /control.txt $dbarray. ./output.txt

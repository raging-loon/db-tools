# $controlfile = Get-Content "./5000-words.txt";
# $db_file = Get-Content "./5000-words.txt.bak";
# $outfile = "output.txt";


function do_exclusive_sort{
  param (
    [String]$controlfile,
    [String[]]$dbfiles,
    [String]$output
  )
  for(($i = 0); $i -lt $dbfiles.Count; $i++){
    $dbcontents = Get-Content $dbfiles[$i]
    foreach($line in Get-Content $controlfile){
      if($dbcontents -contains $line){
        continue
      } else {
        $line | Out-File -FilePath $output -Append
      }
    }
  }
}
$dbarray = @('./db1.txt','./db2.txt')

do_exclusive_sort ./control.txt -dbfiles $dbarray -output ./output.txt

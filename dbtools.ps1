# $controlfile = Get-Content "./5000-words.txt";
# $db_file = Get-Content "./5000-words.txt.bak";
# $outfile = "output.txt";


function do_exclusive_sort{
  param (
    [String]$controlfile,
    [String[]]$dbfiles,
    [String]$output
  )
  $unique_entries = @();
  for(($i = 0); $i -lt $dbfiles.Count; $i++){
    $dbcontents = Get-Content $dbfiles[$i]
    foreach($line in Get-Content $controlfile){
      if($dbcontents -contains $line || $unique_entries -contains $line){
          continue
      } else {
        $unique_entries += $line
      }

    }
  }
  foreach($entry in $unique_entries){
    $entry | Out-File -FilePath $output -Append
  }
}

$dbarray = @('./db1.txt','./db2.txt')
# for testing vv
do_exclusive_sort ./control.txt -dbfiles $dbarray -output ./output.txt

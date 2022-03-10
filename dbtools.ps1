function exclusive_sort{
  param (
    [String]$controlfile,
    [String[]]$dbfiles,
    [String]$output
  )
  $unique_entries = @();
  for(($i = 0); $i -lt $dbfiles.Count; $i++){
    $dbcontents = Get-Content $dbfiles[$i]
    foreach($line in Get-Content $controlfile){
      
      if($dbcontents -contains $line -or $unique_entries -contains $line){
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
exclusive_sort ./control.txt -dbfiles $dbarray -output ./output.txt

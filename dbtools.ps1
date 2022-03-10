# Set-Variable -Name EXCLUSIVE_SORT -Value 1 -Option Constant -Scope Global -Force
# Set-Variable -Name INCLUSIVE_SORT -Value 2 -Option Constant -Scope Global -Force
$EXCLUSIVE_SORT = 1
$INCLUSIVE_SORT = 2
function in_ex_clusive_sort{
  param (
    [int32]$type,
    [String]$controlfile,
    [String[]]$dbfiles,
    [String]$output
  )
  $unique_entries = @();
  for(($i = 0); $i -lt $dbfiles.Count; $i++){
    $dbcontents = Get-Content $dbfiles[$i]
    foreach($line in Get-Content $controlfile){
      
      if($dbcontents -contains $line -or $unique_entries -contains $line){
        if($type -eq 1){
          continue
        } else {
          $unique_entries += $line
        }
      } else {
        if($type -eq 1){
          $unique_entries += $line
        } else {
          continue;
        }
      }

    }
  }
  foreach($entry in $unique_entries){

    $entry | Out-File -FilePath $output -Append
  }
}



$dbarray = @('./db1.txt','./db2.txt')
# for testing vv
in_ex_clusive_sort -type $EXCLUSIVE_SORT ./control.txt -dbfiles $dbarray -output ./output.txt

Import-Module $PSScriptRoot\err.psm1
<#
  @function in_ex_clusive_sort
  IN/EXclusive sort function
  Takes the type of sort(users the constants) and sorts based on that
  Takes a control file($controlfile), used to compare with the $dbfiles and
  will output it in $output
#>
function in_ex_clusive_sort{
    param (
      [int32]$type,
      [String]$controlfile,
      [String[]]$dbfiles,
      [String]$output
    )
  
    Write-Host $__controlfile
    foreach($i in $dbfiles){
      Write-Host "Debug: db_file: $i";
    }
    if($dbfiles.Count -eq 0){
      new_error_box -message "Not enough database files"
      return
    } elseif($dbfile.Count -gt 4){
      new_error_box -message "Too many database files"
      return
    }
    
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


# make these constants
$EXCLUSIVE_SORT = 1
$INCLUSIVE_SORT = 2

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

function init_gui(){
  Add-Type -AssemblyName System.Windows.Forms
  $dbtools_window = New-Object System.Windows.Forms.Form;
  $dbtools_window.Text = "DB-Tools";
  $dbtools_window.AutoSize = $true;
  $win_toolbar = New-Object System.Windows.Forms.MenuStrip;
  $openfiles = New-Object System.Windows.Forms.ToolStripMenuItem;
  $win_toolbar.Items.AddRange(@(
    $openfiles;
  ));
  $win_toolbar.Location = New-Object System.Drawing.Point(0,0);
  $win_toolbar.Name ="Toolbar";
  $win_toolbar.TabIndex = 0;
  $dbtools_window.Controls.Add($win_toolbar)
  $dbtools_window.ShowDialog();
  # addhelp

}

init_gui
[void][Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
[void][Reflection.Assembly]::LoadWithPartialName("System.Drawing")

$global:__controlfile = $null
$global:__dbfile = @();

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
  if($dbfiles.Count -eq 0 -or $dbfiles.Count -gt 4){
    Write-Host "Too many or not enough database files";
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
function open_file_menu($Sender){
  $browser = New-Object System.Windows.Forms.OpenFileDialog -Property @{
     InitialDirectory = [Environment]::GetFolderPath('Desktop')
    }
  $browser.ShowDialog()
  $__controlfile = $browser.FileName
}

function init_gui(){
  Add-Type -AssemblyName System.Windows.Forms
  # set up variables
  

  # set up main window
  $dbtools_window = New-Object System.Windows.Forms.Form;
  $dbtools_window.Text = "DB-Tools";
  $dbtools_window.AutoSize = $true;
  # set up tool bar
  $win_toolbar = New-Object System.Windows.Forms.MenuStrip;

  $openfiles = New-Object System.Windows.Forms.ToolStripMenuItem;
  $open_controlfile = New-Object System.Windows.Forms.ToolStripMenuItem;
  $open_db_file = New-Object System.Windows.Forms.ToolStripMenuItem;
  $help_item = New-Object System.Windows.Forms.ToolStripMenuItem;
  $run_tool = New-Object System.Windows.Forms.ToolStripMenuItem;
  # set text
  $openfiles.Text = "File";
  $open_db_file.Text = "Open Database File"
  $open_controlfile.Text = "Open Control File"
  $help_item.Text = "Help"
  $run_tool.Text = "Run";
  $open_controlfile.Add_Click({open_file_menu $dbtools_window})
  $run_tool.Add_Click({in_ex_clusive_sort -type 1 -controlfile $__controlfile -dbfiles $__dbfile -output "output.txt"})
  # add sub menues
  $openfiles.DropDownItems.AddRange(@(
    $open_controlfile,
    $open_db_file
    
  ))
  # add tool bar items to tool bar
  $win_toolbar.Items.AddRange(@(
    $openfiles,
    $help_item
    $run_tool
    ));
  $win_toolbar.Location = New-Object System.Drawing.Point(0,0);
  $win_toolbar.Name ="Toolbar";
  $win_toolbar.TabIndex = 0;
  $dbtools_window.Controls.Add($win_toolbar)
  $dbtools_window.ShowDialog();
  # addhelp
}

init_gui
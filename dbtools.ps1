# cli args
Param(
    [Parameter()]
    [Switch]$start_gui,
    [int32]$type,
    [String]$controlfile,
    [String[]]$dbfiles,
    [String]$outputfile    
)

[void][Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
[void][Reflection.Assembly]::LoadWithPartialName("System.Drawing")
Import-Module $PSScriptRoot\basic-sort.psm1 -Function in_ex_clusive_sort

# make these constants

$EXCLUSIVE_SORT = 1
$INCLUSIVE_SORT = 2


function open_file_menu($Sender,$fname){
  $browser = New-Object System.Windows.Forms.OpenFileDialog -Property @{
     InitialDirectory = [Environment]::GetFolderPath('Desktop')
    }
  $browser.ShowDialog()
  $fname = $browser.FileName
  # $Sender.
}
function open_db_file_menu($sender,$fname){
  $browser = New-Object System.Windows.Forms.OpenFileDialog -Property @{
    InitialDirectory = [Environment]::GetFolderPath('Desktop')
  }
  $browser.ShowDialog()
  $fname += $browser.FileName
}

<#
  Handles all GUI features except for opening files

#>
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
  # set functions
  $open_controlfile.Add_Click({open_file_menu $dbtools_window $__controlfile})
  $run_tool.Add_Click({in_ex_clusive_sort -type 1 -controlfile $__controlfile -dbfiles $__dbfile -output "output.txt"})
  $open_db_file.Add_Click({open_db_file_menu $dbtools_window $__dbfile})
  # add sub menues
  $openfiles.DropDownItems.AddRange(@(
    $open_controlfile,
    $open_db_file
    
  ))
  # make labels
   
  $cf_labal = New-Object System.Windows.Forms.Label;


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
  $dbtools_window.Controls.Add($cf_labal)
  $dbtools_window.ShowDialog();
  # add help
}



if($start_gui){
    init_gui
} else {
    in_ex_clusive_sort $type $controlfile -dbfile $dbfiles -output $outputfile

}

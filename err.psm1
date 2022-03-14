
function new_error_box{
    Param(
      [String]$Message
    )
    Add-Type -AssemblyName PresentationFramework
    $title = "Error"
    $btype = [System.Windows.MessageBoxButton]::OK;
    $icon = [System.Windows.MessageBoxImage]::Error;
    [System.Windows.MessageBox]::Show($Message,$title,$btype,$icon) 
  }
  
Export-ModuleMember -Function new_error_box
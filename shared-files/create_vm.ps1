﻿$VM = $args[0]
$CPU = $args[1]
$RAM = $args[2]

new-item "D:\$VM" -itemtype directory
new-item "D:\$VM\Virtual Hard Disks" -itemtype directory
$Path = "D:\" + $VM
$Source = 'E:\ExportVM\template_CentOS7\Virtual Machines\B2934589-A1E9-4CCD-834C-F44D145A78E4.vmcx'
$Import = Import-VM -Path $Source -Copy -GenerateNewId -VirtualMachinePath $Path -VhdDestinationPath "D:\$VM\Virtual Hard Disks" -SnapshotFilePath $Path
Foreach ($Import in $Import)
{
    $oldName = $Import.Name
    Rename-VM $oldName -NewName $VM
}

SET-VMProcessor -VMname "$VM" -count $CPU
Set-VMMemory $VM -StartupBytes $RAM

Start-VM -Name $VM

Get-WmiObject Win32_LogicalDisk -filter "DeviceID='C'"| Out-File C:\Users\Nash\Desktop\testt.txt -Append

Get-date | Out-File C:\Users\Nash\Desktop\testt.txt -Append
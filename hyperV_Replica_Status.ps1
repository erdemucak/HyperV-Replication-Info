$server = @("dtl1hyperv1","dtl1hyperv2","dtl1hyperv3","dtl1hyperv4","dtl1hyperv5","dtl1hyperv6","dtl1hyperv7","dtl1hyperv8","dtl1hyperv9") 
ForEach($item in $server){
Invoke-Command -ComputerName $server -ScriptBlock { Get-VMReplication | Select-Object VMName,State,Health,LastReplicationTime,ReplicaServer } | ConvertTo-Html -title "Hyper-V Replication Status"  | Out-File -FilePath C:\ScheduledTasks\HyperVReplications\report\replications.html }
cd C:\ScheduledTasks\HyperVReplications\report
$repcount= cat replications.html | Measure-Object | %{ $_.Count-10 }
Send-MailMessage -Attachments "C:\ScheduledTasks\HyperVReplications\report\replications.html" -From replica@digiturk.com.tr -To techinfracorpbo@digiturk.com.tr -Body "Replikasyonu Yapilan Sunucu Sayisi: $repcount " -Subject "Hyper-V Replication Status" -SmtpServer 172.28.1.100
Remove-Item -Path C:\ScheduledTasks\HyperVReplications\report\replications.html
exit
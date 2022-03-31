<#Vendor Invoices Quarantine Check#>
Connect-ExchangeOnline
$SMTPServer = 'csseg2.cameronbp.com'
$email = Get-QuarantineMessage | Select-Object SenderAddress,type,Subject, MessageID,RecipientAddress | Where-Object{$_.RecipientAddress -like "vendorinvoices@cameronashleybp.com"} | Out-String

if ($Email.count -lt 2) {$email = " NONE FOUND"}

Send-MailMessage -To "Markthompson@cameronashleybp.com"  -From 'quarantine@cameronashleybp.com' -SmtpServer $SMTPServer -Subject 'Vendor Invoice Quarantined' -Body $email



Disconnect-ExchangeOnline -Confirm:$false
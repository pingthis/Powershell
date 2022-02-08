$Folder  = 'C:\Support\Juniper\reject\'
$CsvOut = 'C:\Support\Juniper\reject\Output.csv'

$Files = Get-ChildItem -Path $Folder -File |
    Select-Object -ExpandProperty FullName

$Results = foreach( $File in $Files ){
    $Lines = Select-String -Path $File -Pattern 'IP Address' -Context 0,3

    #$CIDR = $Lines.Context.PostContext[0] |
    #    Where-Object { $_ -match 'CIDR' }

    [pscustomobject]@{
        $Address = $Lines.Context.PostContext[0]
       }
    }

$Results #| Export-Csv -Path $CsvOut -NoTypeInformation
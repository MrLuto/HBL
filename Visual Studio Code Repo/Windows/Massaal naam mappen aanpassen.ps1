$sharepoint = "C:\Users\MatthiasBooneIT\Boone IT\Klanten - Documenten"
$oude_naam = "1. Documenatie Netwerk"
$nieuwe_naam = "1. Documentatie Netwerk"
Get-ChildItem -Path $sharepoint -Recurse -Filter "*$oude_naam*" | Rename-Item -NewName {$_.name -replace $oude_naam, $nieuwe_naam}
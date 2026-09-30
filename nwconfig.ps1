# Holt den Hostnamen des Computers
$Hostname = hostname

# Holt alle aktiven Netzwerkadapter mit einer IP-Adresse
$NetworkAdapters = Get-CimInstance -ClassName Win32_NetworkAdapterConfiguration | Where-Object { $_.IPEnabled -eq $true }

# Gibt die Header-Zeile aus
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "   Netzwerk-Informationen für $Hostname     " -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan

# Schleife durch alle aktiven Netzwerkadapter
foreach ($Adapter in $NetworkAdapters) {
    Write-Host "Adapter: $($Adapter.Description)" -ForegroundColor Yellow
    Write-Host "--------------------------------------------------"
    Write-Host "Hostname:         $Hostname"
    Write-Host "IP-Adresse(n):    $($Adapter.IPAddress -join ', ')"
    Write-Host "Subnetzmaske(n):  $($Adapter.IPSubnet -join ', ')"
    Write-Host "Standardgateway:  $($Adapter.DefaultIPGateway -join ', ')"
    Write-Host "DNS-Server:       $($Adapter.DNSServerSearchOrder -join ', ')"
    
    # Prüft, ob DHCP aktiv ist und gibt Ja/Nein aus
    if ($Adapter.DHCPEnabled) {
        Write-Host "DHCP aktiv:       Ja" -ForegroundColor Green
    } else {
        Write-Host "DHCP aktiv:       Nein" -ForegroundColor Red
    }
    Write-Host ""
}
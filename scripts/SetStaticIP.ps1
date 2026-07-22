# Sets a static IP address, subnet mask, default gateway, and DNS server
# on a specified network adapter. Used during initial setup of both
# DC01 and FS01.

New-NetIPAddress -InterfaceAlias "Ethernet0" -IPAddress 192.168.10.10 -PrefixLength 24 -DefaultGateway 192.168.10.1
Set-DnsClientServerAddress -InterfaceAlias "Ethernet0" -ServerAddresses 127.0.0.1

# For FS01: change IP to 192.168.10.20 and DNS to 192.168.10.10

Invoke-WebRequest -uri "https://www.spamhaus.org/drop/drop.txt" -OutFile .\drop.txt

Invoke-WebRequest -uri "http://www.malwaredomainlist.com/hostslist/ip.txt" -OutFile .\ip.txt
# torrocks 
[![GitHub license](https://img.shields.io/github/license/okno/torrocks.svg)](https://github.com/okno/torrocks/blob/master/LICENSE)
Run your own TOR exit node & control it with Tor Control Center (TCC)

Templates for a secure Tor exit node configuration

Files: 

File  | Description
------------- | -------------
torrc  | **Main configuration file**
tor-exit-notice.html | Html template for Tor data port
tor.conf | Nginx template for hidden service

# TOR Control Center (TCC)

Install arm for Tor

    apt update
    apt install tor-arm
    
Install tmux 

    apt install tmux 
    


This is how my TCC look like : 
![](https://raw.githubusercontent.com/okno/torrocks/master/torrocks.png)

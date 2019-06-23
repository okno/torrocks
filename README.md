# torrocks 
[![GitHub license](https://img.shields.io/github/license/okno/torrocks.svg)](https://github.com/okno/torrocks/blob/master/LICENSE)      [![GitHub issues](https://img.shields.io/github/issues/okno/torrocks.svg)](https://github.com/okno/torrocks/issues) [![GitHub stars](https://img.shields.io/github/stars/okno/torrocks.svg)](https://github.com/okno/torrocks/stargazers) [![Twitter](https://img.shields.io/twitter/url/https/github.com/okno/torrocks.svg?style=social)](https://twitter.com/intent/tweet?text=Wow:&url=https%3A%2F%2Fgithub.com%2Fokno%2Ftorrocks)


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

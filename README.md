
<p align="center"><a href="https://www.torproject.org/" target="_blank"><img src="https://2019.www.torproject.org/images/tor-logo.png" /></a></p>

# torrocks 
[![GitHub license](https://img.shields.io/github/license/okno/torrocks.svg)](https://github.com/okno/torrocks/blob/master/LICENSE) [![GitHub issues](https://img.shields.io/github/issues/okno/torrocks.svg)](https://github.com/okno/torrocks/issues) [![GitHub stars](https://img.shields.io/github/stars/okno/torrocks.svg)](https://github.com/okno/torrocks/stargazers) [![Twitter](https://img.shields.io/twitter/url/https/github.com/okno/torrocks.svg?style=social)](https://twitter.com/intent/tweet?text=Wow:&url=https%3A%2F%2Fgithub.com%2Fokno%2Ftorrocks)

Run your own TOR exit node & control it with Tor Control Center (TCC)

Templates for a secure Tor exit node configuration

### TOR overview
Tor is free and open-source software for enabling anonymous communication. The name is derived from an acronym for the original software project name "The Onion Router". Tor directs Internet traffic through a free, worldwide, volunteer overlay network consisting of more than seven thousand relays to conceal a user's location and usage from anyone conducting network surveillance or traffic analysis. Using Tor makes it more difficult to trace Internet activity to the user: this includes "visits to Web sites, online posts, instant messages, and other communication forms". Tor's intended use is to protect the personal privacy of its users, as well as their freedom and ability to conduct confidential communication by keeping their Internet activities from being monitored. [wikipedia](https://en.wikipedia.org/wiki/Tor_(anonymity_network))

### Files: 

File  | Description
------------- | -------------
[torrc](https://github.com/okno/torrocks/blob/master/torrc)  | **Main configuration file**
[tor-exit-notice.html](https://github.com/okno/torrocks/blob/master/tor-exit-notice.html) | Html template for Tor data port
[tor.conf](https://github.com/okno/torrocks/blob/master/tor.conf) | Nginx template for hidden service
[notices.log](https://github.com/okno/torrocks/blob/master/notices.log) | Sample log file

### TOR Control Center (TCC)

TCC is a simple method to monitor the health state of yout Tor Exit Node, just open tmux, split in 4 terms, run tailf, netstat, arm and have fun with a beer.

#### Requirements 

* tmux 
* arm 
* netstat 
* tailf 

Install arm for Tor

    apt update
    apt install tor-arm
    
Install tmux 

    apt install tmux 

This is how my TCC look like : 
![](https://raw.githubusercontent.com/okno/torrocks/master/torrocks.png)

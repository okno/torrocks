<p align="center">
<a href="https://www.torproject.org/" target="_blank"><img src="https://2019.www.torproject.org/images/tor-logo.png" /></a><br />
<img src="https://raw.githubusercontent.com/okno/torrocks/master/torrocks.screenshot.png" />
</p>

# torrocks 

[![GitHub license](https://img.shields.io/github/license/okno/torrocks.svg)](https://github.com/okno/torrocks/blob/master/LICENSE) [![GitHub issues](https://img.shields.io/github/issues/okno/torrocks.svg)](https://github.com/okno/torrocks/issues) [![GitHub stars](https://img.shields.io/github/stars/okno/torrocks.svg)](https://github.com/okno/torrocks/stargazers) [![Twitter](https://img.shields.io/twitter/url/https/github.com/okno/torrocks.svg?style=social)](https://twitter.com/intent/tweet?text=Wow:&url=https%3A%2F%2Fgithub.com%2Fokno%2Ftorrocks)

Run your own TOR exit node & control it with Tor Control Center (TCC)

Templates for a secure Tor exit node configuration

### AIM

The purposals of **torrocks** is to give an overview on Tor, Hidden Services, and monitoring with a series of best practices, reviewd documentation, scripts and tips.

###### To Do

- [x] Install script (bash)
- [x] Upload torrocks project 
- [x] Manage script (bash)
- [ ] Securty script (bash)
- [x] Write base README.md
- [ ] Write Complete documentation
- [ ] Add The Onion Box Web interface integration
- [ ] Bugfix


### Tor overview
Tor is free and open-source software for enabling anonymous communication. The name is derived from an acronym for the original software project name "The Onion Router". Tor directs Internet traffic through a free, worldwide, volunteer overlay network consisting of more than seven thousand relays to conceal a user's location and usage from anyone conducting network surveillance or traffic analysis. Using Tor makes it more difficult to trace Internet activity to the user: this includes "visits to Web sites, online posts, instant messages, and other communication forms". Tor's intended use is to protect the personal privacy of its users, as well as their freedom and ability to conduct confidential communication by keeping their Internet activities from being monitored. [(Wikipedia)](https://en.wikipedia.org/wiki/Tor_(anonymity_network))

### Clean old Tor install & purge:
Remove old installation and configurations files that could create problems during the setup of torrocks.(Not mandatory)

    # sudo service tor stop
    # sudo killall -9 tor
    # sudo apt remove -y --purge tor tor-arm tor-geoipdb  python-geoip python-torctl torsocks
    # sudo apt autoremove 
    # sudo rm -rf /var/log/tor
    # sudo rm -rf -rf /etc/tor

### Download & Install torrocks
    
    # cd /opt
    # sudo git clone https://github.com/okno/torrocks
    # sudo chmod +x /opt/torrocks/torrocks.sh
    # sudo ln -s /opt/torrocks/torrocks.sh /usr/bin/torrocks
    
Check if torrocks symbolic link is correctly placed : 

    ls -al /usr/bin/torrocks 
    
Output : 

    lrwxrwxrwx 1 root root 25 Jun 23 23:21 /usr/bin/torrocks -> /opt/torrocks/torrocks.sh
    
### Install Tor

You can find **Tor** inside the most OS,be sure to install the latest version, on Linux Debian 9.9 stretch  just type : 

    # sudo apt update 
    # sudo apt install tor -y 
    # sudo service tor start
    
If everything is ok **Tor** daemon should be up and running with default configuration, listening on 127.0.0.1 on port 9050, to check your Tor deamon you can use : 

    # sudo netstat -putan | grep tor
    
You should see an output like this : 

    tcp        0      0 127.0.0.1:9050          0.0.0.0:*               LISTEN      13302/tor
    
Now check if the tor process is running by the user **debian-tor** : 

    # sudo ps -u debian-tor
    
Output : 

    PID TTY          TIME CMD
    13302 ?        00:00:01 tor
    
You can also check the status of the deamon whit the **service** command of systemd(shit)

    # sudo service tor status
    
Output : 

    ● tor.service - Anonymizing overlay network for TCP (multi-instance-master)
    Loaded: loaded (/lib/systemd/system/tor.service; enabled; vendor preset: enabled)
    Active: active (exited) since Sun 2019-06-23 15:39:58 BST; 22min ago
    Process: 13295 ExecStart=/bin/true (code=exited, status=0/SUCCESS)
    Main PID: 13295 (code=exited, status=0/SUCCESS)
    Tasks: 0 (limit: 4915)
    CGroup: /system.slice/tor.service
    Jun 23 15:39:58 HOSTNAME systemd[1]: Starting Anonymizing overlay network for TCP (multi-instance-master)...
    Jun 23 15:39:58 HOSTNAME systemd[1]: Started Anonymizing overlay network for TCP (multi-instance-master).

Ok, now we are sure that the `tor` daemon is running with PID `13302`, with user `debian-tor`, listening on `127.0.0.1` on port `9050`

 :warning: Never run Tor with root user :warning:

### Paths, Logs, Files: 
File  | Description
------------- | -------------
/var/log/tor/ | Default log Tor directory
/usr/share/doc/tor | Sample config&template files for tor and hidden services
/var/log/tor/notices.log | Tor health log (best for Tor service analysis)
/var/log/tor/debug.log | Tor debug log (best for debugging & network analysis)
/etc/tor | Tor configurations files
/etc/tor/torrc | Tor daemon configuration file

###### Torrocks Files:
File  | Description
------------- | -------------
[torrc](https://github.com/okno/torrocks/blob/master/torrc)  | **Main configuration file**
[tor-exit-notice.html](https://github.com/okno/torrocks/blob/master/tor-exit-notice.html) | Html template for Tor data port
[tor.conf](https://github.com/okno/torrocks/blob/master/tor.conf) | Nginx template for hidden service
[notices.log](https://github.com/okno/torrocks/blob/master/notices.log) | Sample log file

## Tor Control Center (TCC)

TCC is a simple method to monitor the health state of yout Tor Exit Node, just open tmux, split in 4 terms, run tailf, netstat, arm and have fun with a beer.

#### Requirements 

* tor
* tmux 
* arm 
* netstat 

Install arm for Tor

    # sudo apt update
    # sudo apt install tor-arm
    
Install tmux 

    # sudo apt install tmux 

This is how my Tor Control Center looks like : 
![](https://raw.githubusercontent.com/okno/torrocks/master/torrocks.png)

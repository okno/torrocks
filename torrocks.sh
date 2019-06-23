#!/bin/bash
#
# Copyright (c) Pawel 'okno' Zorzan Urban
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
# #THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# #EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

# Internal Vars
RES='\033[0m'
RED='\033[00;31m'
GREEN='\033[00;32m'
YELLOW='\033[00;33m'
BLUE='\033[00;34m'
PURPLE='\033[00;35m'
CYAN='\033[00;36m'
LIGHTGRAY='\033[00;37m'
LRED='\033[01;31m'
LGREEN='\033[01;32m'
LYELLOW='\033[01;33m'
LBLUE='\033[01;34m'
LPURPLE='\033[01;35m'
LCYAN='\033[01;36m'
WHITE='\033[01;37m'
year=$(date +%Y)
separator="--------------------------------------------"
torlog="/var/log/tor/notices.log"
torbin="/usr/bin/tor"
tmuxbin="/usr/bin/tmux"
armbin="/usr/bin/arm"
tailfbin="/usr/bin/tailf"
# END Internal Vars
# Standard Debug function
function DeBug() {
exec 5> >(logger -t $0)
BASH_XTRACEFD="5"
PS4='$LINENO: '
set -x
echo $separator
echo -e " > \033[00;31m!!\033[0m Debug mode ON"
}
# END Debug function
# Print License 
function license.torrocks() {
cat <<EOF
Copyright (c) $year Pawel 'okno' Zorzan Urban

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:
The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
$separator
EOF
exit 0
}
# Print Banner Function
function banner.torrocks() {
cat <<EOF 
$separator
████████╗ ██████╗ ██████╗ ██████╗  ██████╗  ██████╗██╗  ██╗███████╗
╚══██╔══╝██╔═══██╗██╔══██╗██╔══██╗██╔═══██╗██╔════╝██║ ██╔╝██╔════╝
   ██║   ██║   ██║██████╔╝██████╔╝██║   ██║██║     █████╔╝ ███████╗
   ██║   ██║   ██║██╔══██╗██╔══██╗██║   ██║██║     ██╔═██╗ ╚════██║
   ██║   ╚██████╔╝██║  ██║██║  ██║╚██████╔╝╚██████╗██║  ██╗███████║
   ╚═╝    ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝  ╚═════╝╚═╝  ╚═╝╚══════╝                                                                 
        version      1.0
        Created by   Pawel 'okno' Zorzan Urban
        Report bugs  mail@pawelzorzan.eu
        Homepage     https://www.pawelzorzan.eu https://userkernel.space
        License      MIT ($year)
$separator
EOF
}
#Print Usage Function
function printUsage() {
    cat <<EOF
    Usage :
    $0 [-u update] [-l license] [-h help] [-c check Tor status]
    -c 
    check Tor daemon status
    -u update
	Update and Exit 0
        Update torrocks from official Gitbub repo (https://github.com/okno/torrocks)
    -l license
        Print License and Exit 0
    -h help
	Print help options and Exit 0
$separator
EOF
}
function update.torrocks() {
            while true; do
    					read -p " > Do you wish to update torrocks from Github? (y/n) " yn
    					case $yn in
      					[Yy]* ) git pull;;
       					[Nn]* ) echo " > No changes." ; exit 0 ;;
       					 * ) echo " > Please answer yes(y/Y) or no(n/N).";;
    					esac
			done
			updok=$?
			if [ $updok == "0" ]
				then
  						echo -e " >$GREEN Successfully updated!$RES"
                        echo $separator
					  	exit 0
				else
 					    echo -e " > $RED! ERROR$RES -> Check your Proxy, Internet Connection or Git response" 
  					    echo $separator
					    exit 1
			fi
}
#torrocks commands Function
function torrocks.cmd() {
            alias torrocks.stop = "tmux kill-session"
            alias torrocks.identity = "service tor reload"
}
function torrocks.TCC() {
            cat <<EOF
> Starting torrocks...
EOF
            echo $separator
            echo "> Checking Tor daemon configuration" 
            if [ -f "$torbin" ]; then
                    echo -e "> Checking Tor ...$GREEN found!$RES"
                else 
                    echo -e " > $RED! ERROR$RES -> Tor not found in $torbin"
                    echo "   If your installation have a different path modify the (torbin) var in this script."
                    exit 1
            fi
            tor --verify-config > /tmp/torrc.log
            chktor=$?
            if [ $chktor == "0" ]
				then
  						echo -e ">$GREEN Tor daemon configuration is Valid$RES"
				else
 					    echo -e " > $RED! ERROR$RES -> Error in $torbin - Tor configuration NOT VALID"
                        cat /tmp/torrc.log 
  					    echo $separator
					    exit 1
			fi
            if [ -f "$tmuxbin" ]; then
                    echo -e "> Checking tmux ...$GREEN found!$RES"
                else 
                    echo -e " > $RED! ERROR$RES -> tmux not found in $tmuxbin"
                    echo "   If your installation have a different path modify the (tmuxbin) var in this script."
                    exit 1
            fi
            if [ -f "$armbin" ]; then
                    echo -e "> Checking tor-arm ...$GREEN found!$RES"
                else 
                    echo -e " > $RED! ERROR$RES -> tor-arm not found in $armbin"
                    echo "   If your installation have a different path modify the (armxbin) var in this script."
                    exit 1
            fi
            tmux new-session \; \
            send-keys 'echo 1' C-m \; \
            split-window -h \; \
            send-keys 'tailf ' C-m \; \
            split-window -v \; \
            send-keys 'echo 3' C-m \;
            split-window -v \; \
            send-keys 'echo torrocks - command list:'; 
            echo 'torrocks.stop = Close torrocks' ;
            echo 'torrocks.identity = service tor reload' C-m \;
}
# Remove comment to ENABLE Debug function
#########################################
DeBug
#########################################
# Print banner
banner.torrocks
if [[ $EUID -ne 0 ]]; then
   echo -e "$RED torrocks  must be run as root!$RES" 
   exit 1
fi
while getopts "chlu" opt; do
	case $opt in
		u)
		    update.torrocks
			exit 0;;
        l)
		    echo " > Printing License :";
            echo $separator
            license.torrocks
		    exit 0;;
		h)
			echo " > Printing Usage :";
            echo $separator
						printUsage
			exit 0;;
		c)
			service tor status;
            echo $separator
            echo 0;;
		\?)
			echo -e " > $RED! ERROR$RES -> Invalid option: $OPTARG";
            echo $separator
			exit 1
		;;
	esac
done
torrocks.TCC

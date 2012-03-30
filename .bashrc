# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions

PATH="$PATH":/sbin:/usr/sbin:/usr/local/sbin:/var/www/html/sf_sandbox

alias python='python2.6'
alias scrls='screem -ls'
alias scrr='screen -r'
alias scrd='screem -d'

autoload -U compinit; compinit
bindkey -e

# Ê£¿ô¤Î zsh ¤òÆ±»þ¤Ë»È¤¦»þ¤Ê¤É history ¥Õ¥¡¥¤¥ë¤Ë¾å½ñ¤­¤»¤ºÄÉ²Ã¤¹¤ë
setopt append_history

# »ØÄê¤·¤¿¥³¥Þ¥ó¥ÉÌ¾¤¬¤Ê¤¯¡¢¥Ç¥£¥ì¥¯¥È¥êÌ¾¤È°ìÃ×¤·¤¿¾ì¹ç cd ¤¹¤ë
setopt auto_cd

# 8 ¥Ó¥Ã¥ÈÌÜ¤òÄÌ¤¹¤è¤¦¤Ë¤Ê¤ê¡¢ÆüËÜ¸ì¤Î¥Õ¥¡¥¤¥ëÌ¾¤Ê¤É¤ò¸«¤ì¤ë¤è¤¦¤Ë¤Ê¤ë
setopt print_eightbit

# ¥³¥Þ¥ó¥É¥é¥¤¥ó¤Î°ú¿ô¤Ç --prefix=/usr ¤Ê¤É¤Î = °Ê¹ß¤Ç¤âÊä´°¤Ç¤­¤ë
setopt magic_equal_subst

# Ìá¤êÃÍ¤¬ 0 °Ê³°¤Î¾ì¹ç½ªÎ»¥³¡¼¥É¤òÉ½¼¨¤¹¤ë
setopt print_exit_value

# rm * ¤Ê¤É¤ÎºÝ¡¢ËÜÅö¤ËÁ´¤Æ¤Î¥Õ¥¡¥¤¥ë¤ò¾Ã¤·¤ÆÎÉ¤¤¤«¤Î³ÎÇ§¤·¤Ê¤¤¤è¤¦¤Ë¤Ê¤ë
setopt rm_star_silent

# ¥Õ¥¡¥¤¥ëÌ¾¤Ç #, ~, ^ ¤Î 3 Ê¸»ú¤òÀµµ¬É½¸½¤È¤·¤Æ°·¤¦
setopt extended_glob

# ramdom prompt
#PROMPT="%n@%m:%# "
PROMPT="%# "
#RPROMPT="[%~]"
if [ "$TERM" = "screen" ]; then
	local Mode=$[ $RANDOM % 3 ]
	local Color=$[ $RANDOM % 6 ]
	local RandomColor=$'%{\e[$Mode;$[31+$Color]m%}'
	local Default=$'%{\e[1;m%}'
	setopt PROMPT_SUBST
	PROMPT=${RandomColor}${PROMPT}${Default}
	#RPROMPT=${RandomColor}${RPROMPT}${Default}
fi

# ºÇ¸å¤Ë¼Â¹Ô¤·¤¿¥³¥Þ¥ó¥É¤ò screen ¤Î¥¿¥¤¥È¥ë¤ËÉ½¼¨¤¹¤ë
if [ "$TERM" = "screen" ]; then
	local -a host; host=`/bin/hostname -s`
	preexec() {
		# see [zsh-workers:13180]
		# http://www.zsh.org/mla/workers/2000/msg03993.html
		emulate -L zsh
		local -a cmd; cmd=(${(z)2})
		echo -n "k$host:$cmd[1]:t\\"
	}
fi

# history
HISTFILE=$HOME/.zsh-history
HISTSIZE=100000
SAVEHIST=100000
setopt extended_history
setopt share_history

# set alias
alias rr="rm -rf"
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"
alias ls="ls --color=auto"
alias scrls='screen -ls'
alias scrr='screen -r'
alias scrd='screen -d'
alias scr='screen'
alias vi='vim'

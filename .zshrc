autoload -U compinit; compinit
bindkey -e

# ʣ���� zsh ��Ʊ���˻Ȥ����ʤ� history �ե�����˾�񤭤����ɲä���
setopt append_history

# ���ꤷ�����ޥ��̾���ʤ����ǥ��쥯�ȥ�̾�Ȱ��פ������ cd ����
setopt auto_cd

# 8 �ӥå��ܤ��̤��褦�ˤʤꡢ���ܸ�Υե�����̾�ʤɤ򸫤��褦�ˤʤ�
setopt print_eightbit

# ���ޥ�ɥ饤��ΰ����� --prefix=/usr �ʤɤ� = �ʹߤǤ��䴰�Ǥ���
setopt magic_equal_subst

# ����ͤ� 0 �ʳ��ξ�罪λ�����ɤ�ɽ������
setopt print_exit_value

# rm * �ʤɤκݡ����������ƤΥե������ä����ɤ����γ�ǧ���ʤ��褦�ˤʤ�
setopt rm_star_silent

# �ե�����̾�� #, ~, ^ �� 3 ʸ��������ɽ���Ȥ��ư���
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

# �Ǹ�˼¹Ԥ������ޥ�ɤ� screen �Υ����ȥ��ɽ������
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
if [ $(uname) = 'Darwin' ]; then
	export LSCOLORS=gxfxcxdxbxegedabagacad
	alias ls='ls -aG'
else
	alias ls='ls -a -color=auto'
fi
alias scrls='screen -ls'
alias scrr='screen -r'
alias scrd='screen -d'
alias scr='screen'
alias vi='vim'

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

export GOPATH=~
export PATH=$GOPATH/bin:$PATH

#
# peco incremental search
#
setopt hist_ignore_all_dups

function peco_select_history() {
  local tac
  if which tac > /dev/null; then
    tac="tac"
  else
    tac="tail -r"
  fi
  BUFFER=$(fc -l -n 1 | eval $tac | peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle clear-screen
}
zle -N peco_select_history
bindkey '^r' peco_select_history

#
# ghq incremental search
#
function peco-src () {
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src
bindkey '^]' peco-src

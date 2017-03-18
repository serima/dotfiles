autoload -U compinit; compinit
bindkey -e

# 複数の zsh を同時に使う時など history ファイルに上書きせず追加する
setopt append_history

# 指定したコマンド名がなく、ディレクトリ名と一致した場合 cd する
setopt auto_cd

# 8 ビット目を通すようになり、日本語のファイル名などを見れるようになる
setopt print_eightbit

# コマンドラインの引数で --prefix=/usr などの = 以降でも補完できる
setopt magic_equal_subst

# 戻り値が 0 以外の場合終了コードを表示する
setopt print_exit_value

# rm * などの際、本当に全てのファイルを消して良いかの確認しないようになる
setopt rm_star_silent

# ファイル名で #, ~, ^ の 3 文字を正規表現として扱う
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

# 最後に実行したコマンドを screen のタイトルに表示する
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
alias g='cd $(ghq root)/$(ghq list | peco)'
alias gh='hub browse $(ghq list | peco | cut -d "/" -f 2,3)'

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

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# nodebrew
export PATH="$HOME/.nodebrew/current/bin:$PATH"

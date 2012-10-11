HISTSIZE=5000
HISTFILESIZE=5000


############ GIT CONFIG

typeset -ga preexec_functions
typeset -ga precmd_functions
typeset -ga chpwd_functions

setopt prompt_subst

export __CURRENT_GIT_BRANCH=

	parse_git_branch() {
			git branch --no-color 2> /dev/null \
			| sed -e '/^[^*]/d' -e 's/* \(.*\)/\1 /'
	}

	preexec_functions+='zsh_preexec_update_git_vars'
	zsh_preexec_update_git_vars() {
			case "$(history $HISTCMD)" in 
					*git*)
					export __CURRENT_GIT_BRANCH="$(parse_git_branch)"
					;;
			esac
	}

    chpwd_functions+='zsh_chpwd_update_git_vars'
    zsh_chpwd_update_git_vars() {
            export __CURRENT_GIT_BRANCH="$(parse_git_branch)"
    }

    get_git_prompt_info() {
			if [[ "$__CURRENT_GIT_BRANCH" == " " ]]; then
				echo ""
			else	
            	echo $__CURRENT_GIT_BRANCH
			fi	
    }
##################

#### PARSE JOBS in background, return "n " where n is the number of jobs in background, if there is no jobs in background this will return "".
parse_jobs(){
	jobs -l | wc -l | sed -e 's/ //g' | sed -e 's/$/ /g' | sed -e 's/^0 $//g'
}

alias restartCoreAudio="sudo kill -9 `ps ax|grep 'coreaudio[a-z]' |awk '{print $1}'`"
alias logcat='adb logcat | coloredlogcat.py'
alias mv='nocorrect mv -i'       # no spelling correction on mv
alias cp='nocorrect cp -i'       # no spelling correction on cp
alias mkdir='nocorrect mkdir' # no spelling correction on mkdir
alias tml="tmux list-sessions"
alias tmn="tmux new-session -s"
alias tma="tmux attach-session -t"

alias e="/Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl -n ."

alias dh='df -h'
alias c='cd ~; clear'

alias -g L='|less'
alias -g X='|xargs'
alias -g G='|grep'
alias -g Gi='|grep -i'
alias -g H='|head'
alias -g T='|tail'
alias -g N=' 2>/dev/null &'

alias agi='sudo aptitude install'
alias ags='sudo aptitude search'
alias agh='sudo aptitude show'
alias agu='sudo aptitude update'
alias agg='sudo apt-get upgrade'
alias agr='sudo aptitude remove'
alias agp='sudo aptitude purge'
alias agl='dpkg -l | grep'
alias dki='sudo dpkg -i'
alias agL='dpkg -L'
alias agS='dpkg -S'
alias sscp='rsync -av --partial --progress --inplace'
alias svim='sudo vim'
alias rarx='nice -n 19 rar x'

alias ssource="source ~/.zshrc"

#bindkey -v 		# Vi-style keys
bindkey -e      # Emacs-style commandline editing

alias ls='ls -G'
alias la='ls -la'
alias ll='ls -l'
alias latr='ls -latr'

# Nice prompt
if [ $(hostname) = "xps" ] ; then
	PROMPT=$'%j '$'%{\e[1;31m%}''$(get_git_prompt_info)'$'%{\e[m%}'$'%{\e[1;33m%}%n%{\e[0;37m%}@%{\e[1;34m%}%m%{\e[m%}:%{\e[0;33m%}%30<..<%~%{\e[m%}%(!.#.>) '
else 
	PROMPT=$'%{\e[1;31m%}''$(get_git_prompt_info)'$'%{\e[m%}'$'$(parse_jobs)%{\e[1;34m%}%n%{\e[0;37m%}@%{\e[1;34m%}%m%{\e[m%}:%{\e[0;33m%}%30<..<%~%{\e[m%}%(!.#.>) '
fi
#PROMPT=$'%j %{\e[1;30m%}%n%{\e[0;37m%}@%{\e[1;34m%}%m%{\e[m%}:%{\e[0;33m%}%30<..<%~%{\e[m%}%(!.#.>) '
#PROMPT=$'%j %{\e[1;33m%}%n%{\e[0;37m%}@%{\e[1;34m%}%m%{\e[m%}:%{\e[0;33m%}%30<..<%~%{\e[m%}%(!.#.>) '
#PROMPT=$'%j %{\e[1;35m%}%n%{\e[0;30m%}@%{\e[1;34m%}%m%{\e[m%}:%{\e[0;33m%}%30<..<%~%{\e[m%}%(!.#.>) '

# Git right promtp
#RPROMPT=$'%{\e[1;31m%}''$(get_git_prompt_info)'$'%{\e[m%}'
RPROMPT=

zstyle ':completion:*' completer _list _expand _complete _ignored _match _prefix
zstyle ':completion:*' condition 'NUMERIC != 1'
zstyle ':completion:*' matcher-list '' 'r:|[._-]=* r:|=*' 'm:{a-z}={A-Z} l:|=* r:|=*'
zstyle ':completion:*' match-original both
zstyle ':completion:*' max-errors 1
zstyle :compinstall filename '/root/.zshrc'

if [ -f ~/.ssh/known_hosts ]; then
    hosts=(`awk -F "[, ]" '{print $1}' ~/.ssh/known_hosts`)
fi
if [ -f ~/.ssh/known_hosts2 ]; then
    hosts=($hosts `awk -F "[, ]" '{print $1}' ~/.ssh/known_hosts2`)
fi
if [ -f ~/.ssh/config ]; then
    hosts=($hosts `grep ^Host ~/.ssh/config | sed s/Host\ // | egrep -v '^\*$'`)
fi
zstyle ':completion:*' special-dirs true


autoload -Uz compinit
compinit
# End of lines added by compinstall

#export LC_CTYPE="no_NO.ISO8859-1"
#export __GL_SYNC_TO_VBLANK=1
export LESS=-MM
export TZ='Europe/Oslo'
export CVS_RSH='ssh'
export RSYNC_RSH='ssh'
#export NNTPSERVER='news.scene.org'
export EDITOR=vim

export HISTSIZE=1000000000
export HISTFILE=~/.zsh_history
export SAVEHIST=300000000

reboo() {
bash -c	'read -p "really reboot? (y/n)?"
if [ $REPLY != "y" ]; then
	echo "thougt so..."
	exit 1
fi
ifconfig
';
}

agB () {
   dpkg -L $@ | grep bin
}

PATH=$PATH:/Applications/android-sdk-mac_86/tools
PATH=$PATH:/Applications/android-sdk-mac_86/platform-tools
PATH=$PATH:~/bin
PATH=$PATH:/opt/local/bin
PATH=$PATH:/usr/local/mysql/bin/

compdef -d git

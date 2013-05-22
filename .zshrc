#####################################################################
#    .zshrc by Niko Riitala <nri@iki.fi>. Twitter: @nikoriitala     #
#                   Based on jdong's zshrc file                     #
#         No copyright, feel free to use this, as you like.         #
#####################################################################

# NOTE: this file is bloated and specific to my system
# you probably do not want to use this file bluntly
# possible points of interest:
# aliases, git-aware PS1, colors, functions, completion

# next lets set some enviromental/shell pref stuff up
# setopt NOHUP
#setopt NOTIFY
#setopt NO_FLOW_CONTROL
setopt INC_APPEND_HISTORY SHARE_HISTORY
setopt APPEND_HISTORY
# setopt AUTO_LIST		# these two should be turned off
# setopt AUTO_REMOVE_SLASH
# setopt AUTO_RESUME		# tries to resume command of same name
unsetopt BG_NICE		# do NOT nice bg commands
setopt CORRECT			# command CORRECTION
setopt EXTENDED_HISTORY		# puts timestamps in the history
setopt HASH_CMDS		# turns on hashing
setopt HASH_DIRS		# turns on hashing
#
setopt MENUCOMPLETE
setopt ALL_EXPORT
# fix keys on os x 
bindkey "[3~" delete-char

# Set/unset  shell options
setopt   notify globdots correct pushdtohome cdablevars autolist
setopt   correctall autocd recexact longlistjobs
setopt   autoresume histignoredups pushdsilent 
setopt   autopushd extendedglob rcquotes mailwarning
unsetopt bgnice autoparamslash

# Autoload zsh modules when they are referenced
zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof
#zmodload -ap zsh/mapfile mapfile

PATH="/opt/local/bin:/opt/local/sbin:/usr/local/bin:/usr/local/sbin/:/usr/games/:~/bin/:$PATH:/home/niko/scripts/"
TZ="Europe/Helsinki"
HISTFILE=$HOME/.zhistory
HISTSIZE=1000
SAVEHIST=1000
HOSTNAME="`hostname`"
PAGER='less'
EDITOR='vim'
    autoload colors zsh/terminfo
    if [[ "$terminfo[colors]" -ge 8 ]]; then
   colors
    fi
    for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
   eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
   eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
   (( count = $count + 1 ))
    done
    PR_NO_COLOR="%{$terminfo[sgr0]%}"
PS1="$PR_GREEN%n$PR_BLUE@$PR_YELLOW%m$PR_GREEN:$PR_BLUE%5c/$PR_NO_COLOR%(!.#.$) "
#RPS1="$PR_YELLOW(%D{%d.%m %H:%M:%S})$PR_NO_COLOR"
#LANGUAGE=
LC_ALL='fi_fi.UTF-8'
LANG='fi_FI.UTF-8'
LC_CTYPE=C

if [ $SSH_TTY ]; then
  MUTT_EDITOR=vim
else
  MUTT_EDITOR=emacsclient.emacs-snapshot
fi

unsetopt ALL_EXPORT
# # --------------------------------------------------------------------
# # aliases
# # --------------------------------------------------------------------

# own aliases
#alias l='ls -lh --time-style=long-iso'
alias ls='ls --color=auto'
alias l='ls -lAh'
alias lsu='ls -lAhtr'
alias koko='identify -format "%wx%h"'
alias lsd='ls -l | grep "^d"'
alias sr='screen -rd'
alias eject='drutil tray eject'
alias scpresume='rsync --partial --progress'
alias fotosop='open -a "Adobe Photoshop CS4.app"'
alias un='tar -zxf'
alias ipscan='nmap -sP 192.168.1.1-255'
alias salakala='pwgen -Bs 10 1'
alias www='cd /var/www'
alias tetris='emacs -q --no-splash -f tetris'
alias d='dirs -v | head -10'
alias 1='cd +1'
alias 2='cd +2'
alias 2='cd +2'
alias 3='cd +3'
alias 4='cd +4'
alias 5='cd +5'
alias 6='cd +6'
alias 7='cd +7'
alias 8='cd +8'
alias 9='cd +9'
alias slrn='slrn -n'
alias man='LC_ALL=C LANG=C man'
alias f=finger
alias la='ls -lah'
alias offlineimap-tty='offlineimap -u TTY.TTYUI'
alias hnb-partecs='hnb $HOME/partecs/partecs-hnb.xml'
alias rest2html-css='rst2html --embed-stylesheet --stylesheet-path=/usr/share/python-docutils/s5_html/themes/default/print.css'
alias cp='cp -i'
alias du='du -h'
alias df='df -h'
alias xc='exit'
alias grep='grep -n'
alias errorlog='watch -n5 "tail -55 /var/log/apache2/error.log"'
alias icanhas='sudo apt-get install'
alias remove='sudo apt-get remove'
alias search='apt-cache search'

# typing errors
alias sl='ls'
alias sco='scp'
alias spc='scp'
alias ci='vi'
alias exiy='exit'
alias exity='exit'
alias dc='cd'
alias cd.='cd ..'

# git
alias g='git'
alias gi='git init'
alias gs='git status'
alias ga='git add'
alias gp='git push'
alias gl='git pull'
alias gd='git diff'
alias gc='git commit -v'
alias gcl='git clone'
alias gca='git commit -v -a'
#alias gll='git log --graph --pretty=oneline --abbrev-commit'
#alias gll="git log --graph --pretty=format:'%h %an: %s'"
alias gll="git log --graph --pretty=format:'%h (%ad) %an: %s' --date=short"
# check out what have i done today
alias glll="git log --graph --pretty=format:'%h (%ad) %an: %s' --date=short | grep `date +%Y-%m-%d` | cut -d ':' -f 3- | paste -s -d ','"
alias gf='git diff --name-only HEAD~1 master'
alias gcw='git commit -a -m "$(whatthecommit)"'
alias gfiles='git diff-tree --no-commit-id --name-only -r'
whatthecommit() { curl -s http://whatthecommit.com | perl -p0e '($_)=m{<p>(.+?)</p>}s' }

# drush
alias dst='drush status -show-password'
alias ddl='drush dl'
function ddlen() { /usr/local/bin/drush dl "$@" && /usr/local/bin/drush en "$@" -y ; }
alias ddls='drush dl --select'
alias den='drush en -y'
alias ddis='drush dis -y'
alias dcca='drush cc all'
alias dcron='drush cron'
alias dpml='drush pml'
alias duli='drush uli | sed -e "s/^.*user/user/g"'
alias drdb='drush sql-dump --ordered-dump --result-file=dump.sql'
alias drun='drush pm-uninstall'
alias drfe='drush features'
alias dr='drush'

# alias	=clear

#chpwd() {
#     [[ -t 1 ]] || return
#     case $TERM in
#     sun-cmd) print -Pn "\e]l%~\e\\"
#     ;;
#    *xterm*|screen|rxvt|(dt|k|E)term) print -Pn "\e]2;%~\a"
#    ;;
#    esac
#}

#chpwd

autoload -U compinit
compinit
#bindkey "^?" backward-delete-char
bindkey '^[OH' beginning-of-line
bindkey '^[OF' end-of-line
bindkey '[H' beginning-of-line
bindkey '[F' end-of-line
bindkey '^[[5~' up-line-or-history
bindkey '^[[6~' down-line-or-history
bindkey "^r" history-incremental-search-backward
bindkey ' ' magic-space    # also do history expansion on space
bindkey '^I' complete-word # complete on tab, leave expansion to _expand
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path ~/.zsh/cache/$HOST

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' menu select=1 _complete _ignored _approximate
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/2 )) numeric )'
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'

# Completion Styles

# list of completers to use
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate

# allow one error for every three characters typed in approximate completer
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/2 )) numeric )'
    
# insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions

# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# command for process lists, the local web server details and host completion
# on processes completion complete all user processes
zstyle ':completion:*:processes' command 'ps -au$USER'

## add colors to processes for kill completion
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

#zstyle ':completion:*:processes' command 'ps -o pid,s,nice,stime,args'
#zstyle ':completion:*:urls' local 'www' '/var/www/htdocs' 'public_html'
#
#NEW completion:
# 1. All /etc/hosts hostnames are in autocomplete
# 2. If you have a comment in /etc/hosts like #%foobar.domain,
#    then foobar.domain will show up in autocomplete!
zstyle ':completion:*' hosts $(awk '/^[^#]/ {print $2 $3" "$4" "$5}' /etc/hosts | grep -v ip6- && grep "^#%" /etc/hosts | awk -F% '{print $2}') 
# Filename suffixes to ignore during completion (except after rm command)
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.o' '*?.c~' \
    '*?.old' '*?.pro'
# the same for old style completion
#fignore=(.o .c~ .old .pro)

# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*:*:*:users' ignored-patterns \
        adm apache bin daemon games gdm halt ident junkbust lp mail mailnull \
        named news nfsnobody nobody nscd ntp operator pcap postgres radvd \
        rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs avahi-autoipd\
        avahi backup messagebus beagleindex debian-tor dhcp dnsmasq fetchmail\
        firebird gnats haldaemon hplip irc klog list man cupsys postfix\
        proxy syslog www-data mldonkey sys snort
# SSH Completion
zstyle ':completion:*:scp:*' tag-order \
   files users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle ':completion:*:scp:*' group-order \
   files all-files users hosts-domain hosts-host hosts-ipaddr
zstyle ':completion:*:ssh:*' tag-order \
   users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle ':completion:*:ssh:*' group-order \
   hosts-domain hosts-host users hosts-ipaddr
zstyle '*' single-ignored show

if [[ ${TERM} == "screen-bce" || ${TERM} == "screen" ]]; then
  precmd () { print -Pn "\033k\033\134\033k%1d/\033\134" }
  preexec () { 
      #print -Pn "\033k\033\134\033k%m[$1]\033\134" 
      local CMD=${1[(wr)^(<*|*=*|sudo|exec|-*)]}
      echo -n "\ek$CMD\e\\"
      }
  #precmd () { print -Pn "\033k\033\134\033k%m[%1d]\033\134" }
  #preexec () { print -Pn "\033k\033\134\033k%m[$1]\033\134" }
else
  precmd () { print -Pn "\e]0;%n@%m: %~\a" }
  preexec () { print -Pn "\e]0;%n@%m: $1\a" }
fi

#setopt extended_glob
#preexec () {
#    if [[ "$TERM" == "screen" ]]; then
#        local CMD=${1[(wr)^(*=*|sudo|-*)]}
#        echo -ne "\ek$CMD\e\\"
#    fi
#}

eval $(gdircolors ~/.dir_colors)
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# zgitinit and prompt_wunjo_setup must be somewhere in your $fpath, see README for more.

setopt promptsubst

# Load the prompt theme system
#autoload -U promptinit
#promptinit

# Use the wunjo prompt theme
#prompt wunjo
# git integration

setopt prompt_subst
autoload colors    
colors             

autoload -Uz vcs_info
# set some colors
for COLOR in RED GREEN YELLOW WHITE BLACK CYAN; do
    eval PR_$COLOR='%{$fg[${(L)COLOR}]%}'         
    eval PR_BRIGHT_$COLOR='%{$fg_bold[${(L)COLOR}]%}'
done                                                 
PR_RESET="%{${reset_color}%}"; 

FMT_BRANCH="${PR_GREEN}%b%u%c${PR_RESET}" # e.g. master¹²
FMT_ACTION="(${PR_CYAN}%a${PR_RESET}%)"   # e.g. (rebase-i)
FMT_PATH="%R${PR_YELLOW}/%S"              # e.g. ~/repo/subdir

# check-for-changes can be really slow.
# you should disable it, if you work with large repositories    
zstyle ':vcs_info:*:prompt:*' check-for-changes true
zstyle ':vcs_info:*:prompt:*' unstagedstr '¹'  # display ¹ if there are unstaged changes
zstyle ':vcs_info:*:prompt:*' stagedstr '²'    # display ² if there are staged changes
zstyle ':vcs_info:*:prompt:*' actionformats "${FMT_BRANCH}${FMT_ACTION}//" "${FMT_PATH}"
zstyle ':vcs_info:*:prompt:*' formats       "${FMT_BRANCH}"              "${FMT_PATH}"
zstyle ':vcs_info:*:prompt:*' nvcsformats   ""                             "%~"         

function precmd {       
        vcs_info 'prompt'          
}

function lprompt {
    local brackets=$1
    local color1=$2  
    local color2=$3  
                     
    local bracket_open="${color1}${brackets[1]}${PR_RESET}"
    local bracket_close="${color1}${brackets[2]}"          
                                                             
    local git='$vcs_info_msg_0_'                           
    local cwd="${color2}%B%1~%b"

    PROMPT="${PR_RESET}${bracket_open}${git}${cwd}${bracket_close}%# ${PR_RESET}"
}                                                                                        

function rprompt {
    local brackets=$1
    local color1=$2  
    local color2=$3  
                     
    local bracket_open="${color1}${brackets[1]}${PR_RESET}"
    local bracket_close="${color1}${brackets[2]}${PR_RESET}"
    local colon="${color1}:"                                
    local at="${color1}@${PR_RESET}"                        
                                                            
    local user_host="${color2}%n${at}${color2}%m"                    
    local vcs_cwd='${${vcs_info_msg_1_%%.}/$HOME/~}'        
    local cwd="${color2}%B%20<..<${vcs_cwd}%<<%b"
    local inner="${user_host}${colon}${cwd}"

    RPROMPT="${PR_RESET}${bracket_open}${inner}${bracket_close}${PR_RESET}"
}

function prompti {
    # PS1="$PR_GREEN%n$PR_BLUE@$PR_YELLOW%m$PR_GREEN:$PR_BLUE%5c/$PR_NO_COLOR%(!.#.$) "
    local brackets=$1
    local color1=$2  
    local color2=$3  
    local at="${color1}@${PR_RESET}"                        
    
    local bracket_open="${color1}${brackets[1]}${PR_RESET}"
    local bracket_close="${color1}${brackets[2]}${PR_RESET}"

    local git='$vcs_info_msg_0_'                           
    local cwd="${color2}%B%1~%b"

    PROMPT="$PR_GREEN%n$PR_BLUE@$PR_YELLOW%m$PR_GREEN:$PR_BLUE%5c/$PR_NO_COLOR${bracket_open}${git}${bracket_close} %(!.#.$) "

}

#lprompt '[]' $BR_BRIGHT_BLACK $PR_WHITE
#rprompt '()' $BR_BRIGHT_BLACK $PR_WHITE
prompti '[]' $BR_BRIGHT_BLACK $PR_WHITE

zle-keymap-select() {
  if [[ $KEYMAP = vicmd ]]; then
    echo -ne "\033]12;Red\007"
  else
    echo -ne "\033]12;Green\007"
  fi
}
zle -N zle-keymap-select

zle-line-init () {
  zle -K viins
  if [ $TERM = "rxvt-256color" ]; then
    echo -ne "\033]12;Green\007"
  fi
}
zle -N zle-line-init

bindkey -v
bindkey -M viins '^R' history-incremental-pattern-search-backward
bindkey -M viins '^F' history-incremental-pattern-search-forward

export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;33'
export CLICOLOR=1

source ~/.git-completion.sh
source ~/.git-flow-completion.sh

export LC_ALL=en_US.UTF-8
bindkey "[3~" delete-char
umask 002

[ -s "$HOME/.scm_breeze/scm_breeze.sh" ] && source "$HOME/.scm_breeze/scm_breeze.sh"
[ -s "$HOME/scripts/grep_with_file_shortcuts.zsh" ] && source "$HOME/scripts/grep_with_file_shortcuts.zsh"

diffcolor(){ diff -U3 $1 $2 |sed -e 's/^+/\x1b\[32m+/;s/^-/\x1b[31m-/;s/$/\x1b[0m/'; }
# wgetar(){ wget "$@"; foo=`echo "$@" | sed 's:.*/::'`; tar xzvf $foo; }

function png2ico() { convert $1 -resize 16x16 -colors 256 $2 ;}
mcd(){mkdir -p "$1" && cd "$1"}

function manytimes {
    n=0
    times=$1
    shift
    while [[ $n -lt $times ]]; do
        $@
        n=$((n+1))
    done
}


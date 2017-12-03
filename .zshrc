#!/bin/zsh

#echo "$ZDOTDIR/.zshrc loading ..."

##### オプション設定 #####
# 詳細は man zshoptions を参照

##### 補完
setopt GLOB_COMPLETE
setopt LIST_PACKED

##### ヒストリ
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS

##### 入出力
setopt CORRECT
unsetopt FLOW_CONTROL
setopt MAIL_WARNING
setopt PRINT_EIGHT_BIT
setopt RM_STAR_WAIT

##### プロンプト
setopt PROMPT_SUBST

##### キーバインド #####
bindkey -e
bindkey '^I' complete-word
bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward

##### コマンド履歴 #####
HISTFILE=$ZDOTDIR/.zhistory
HISTSIZE=10000
SAVEHIST=10000

##### プロンプト #####
precmd() {
  precmd_prompt
  case "${TERM}" in
    kterm*|xterm|rxvt*)
      precmd_title
    ;;
  esac
  #precmd_title
}

x_last_exec_time=`date +%s`
precmd_prompt() {
  local u=$(whoami)
  local h=$(hostname)
  local d='mm/dd hh:mm:ss'
  local PWD1=${PWD//\//:}
  local HOME1=${HOME//\//:}
  local p=${${PWD1/$HOME1/\~}//:/\/}
  local p1=$u@$h' <'$d'>'
  local p2='['$p']'
  local x_curr_time=`date +%s`
  local p3=$[$x_curr_time - $x_last_exec_time]
  local fill=$[$COLUMNS - ${#p1} - ${#p2} - ${#p3} - 1]
  if [ $fill -ge 0 ]; then
    PS1=%B%U$u@$h%u' <%D{%m/%d %T} '$p3'>'${(l:${fill}:: :)}$p2%#%b' '
  else
    PS1=%B%U$u@$h%u' <%D{%m/%d %T} '$p3'> [...'${p[$[-($fill)+5],-1]}']'%#%b' '
  fi
}

precmd_title() {
  print -Pn "\e]0;$(hostname):%~\a"
}

preexec() {
  x_last_exec_time=$(date +%s)
}

# 環境変数 LS_COLORS
# command -v dircolors > /dev/null && eval `dircolors ~/.colorrc`
# 補完リストをカラー化
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

##### 関数呼出し #####

autoload -U zmv
# % zmv '(*).jpeg' '$1.jpg'
# % zmv '(**/)foo(*).jpeg' '$1bar$2.jpg'
# % zmv -n '(**/)foo(*).jpeg' '$1bar$2.jpg' # 実行せずパターン表示のみ
# % zmv '(*)' '${(L)1}; # 大文字→小文字
# % zmv -W '*.c.org' 'org/*.c' #「(*)」「$1」を「*」で済ませられる
alias mmv='noglob zmv -W'  # 引数のクォートも面倒なので
# % mmv *.c.org org/*.c
# % zmv -C # 移動ではなくコピー(zcp として使う方法もあるみたいだけど)
# % zmv -L # 移動ではなくリンク(zln として使う方法もあるみたいだけど)

alias ls="ls --color=auto"
alias ll="ls -lh --color=auto"
alias la="ls -A --color=auto"
alias lu="ls -U1"
alias grep="grep --color=auto"
alias mv="mv -i"
alias crontab="crontab -i"
alias resmon="sh ~/scripts/byobu-resmon.sh"

alias emacs-slim="emacs --geometry=120x74"
alias emacs-wide="emacs --geometry=183x80"

alias du1='du --max-depth=1'

# alias SUM='ruby ~/scripts/Summation.rb'
# alias AVG='ruby ~/scripts/Average.rb'
# alias VAR='ruby ~/scripts/Variance.rb'
# alias MED='ruby ~/scripts/Median.rb'
# alias MODE='ruby ~/scripts/Mode.rb'

# alias CEIL='ruby ~/scripts/Ceil.rb'
# alias FLOOR='ruby ~/scripts/Floor.rb'
# alias ROUND='ruby ~/scripts/Round.rb'
# alias TRUNCATE='ruby ~/scripts/Truncate.rb'
# alias HZ2NN='ruby ~/scripts/Hz2NoteNum.rb'

alias procdist='ruby ~/scripts/torque/ProcdistTorque.rb'
alias procdistx='ruby ~/scripts/torque/ProcdistTorqueExclusive.rb'
alias mid2mtx='ruby ~/scripts/mid2mtx.rb'
alias mtx2mid='ruby ~/scripts/mtx2mid.rb'

alias matlab='~/scripts/matlab.sh'
alias jabref='java -jar ~/bib/JabRef-3.8.2.jar'
alias jakld='rlwrap java -Xss1m -jar ~/lib/jakld_revised_20121228.jar'
alias rmap='w3m /n/sd1/adm/rmap.html'
alias msm='/usr/local/MegaRAID\ Storage\ Manager/startupui.sh'
alias rdprigel="sh ~/scripts/rdp-rigel.sh"
alias texclean="sh ~/scripts/texclean.sh"
alias remove_imas_from_classpath="CLASSPATH=$(echo $CLASSPATH | sed 's/:\([^:]*imas[^:]*\):/:/g'); fsc -shutdown"
alias evince='evince 2> >( grep -v "evince.*WARNING" | grep -v "^\s*$" >&2 )'

zmodload -i zsh/mathfunc

function qnodes() {
    if [[ $# -eq 0 ]]; then
        =qnodes | egrep -v "np|ntype|status|gpus|properties|^$"
    elif [[ $# -eq 1 ]] && [[ $1 = -l ]]; then
        =qnodes -l all
    else
        =qnodes $*
    fi
}

function qstat() {
    if [[ $# -eq 0 ]]; then
        =qstat | sed 's/ *$//g'
    elif [[ $# -eq 1 ]] && [[ $1 = -e ]]; then
        =qstat -e | sed 's/ *$//g'
    elif [[ $# -eq 1 ]] && [[ $1 = -Q ]]; then
        =qstat -Q | sed 's/ *$//g'
    else
        =qstat $*
    fi
}

function rmap2() {
    if [ $TERM = putty ]; then
        TERM=vt100 =rmap
    else
        =rmap
    fi
}

function w3m() {
    if [ $TERM = screen ]; then
        TERM=xterm =w3m $*
    else
        =w3m $*
    fi
}

function lw() {
    ls -U1 $* | wc -l
}

##### 補完 #####
autoload -U compinit
compinit

#小文字を入力しても大文字を補完
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

#zstyle ':completion:*:cd:*' tag-order local-directories path-directories
#zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
#autoload -U compdef

##### Windows character encoding convert
# msys2 の ~/.bashrc を参考に
if [ "${OS}" = "Windows_NT" ]; then
  function wincmd(){
    CMD=$1
    shift
    $CMD $* 2>&1 | iconv -f cp932 -t utf-8
  }

  alias ipconfig='wincmd ipconfig'
  alias netstat='wincmd netstat'
  alias netsh='wincmd netsh'
  alias taskkill='wincmd taskkill'
  alias cs="wincmd cscript.exe -NoLogo"
  alias ws="wincmd wscript.exe -NoLogo"
  alias java="wincmd java"
  alias javac="wincmd javac -encoding UTF-8"

  ### interactive commands
  alias scala="winpty scala.bat"
  alias sbt="winpty sbt.bat"
fi

##### ホスト毎の設定 #####
[ -e $ZDOTDIR/.zshrc.$HOST ] && source $ZDOTDIR/.zshrc.$HOST

#echo "$ZDOTDIR/.zshrc loading completed."

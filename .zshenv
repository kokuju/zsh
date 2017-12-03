#!/bin/zsh

#echo "loading $ZDOTDIR/zshenv ..."

######################################################################
##### 環境変数 SHELL を設定 (for msys2)                          #####
######################################################################
[ -z "$SHELL" -a -f /bin/zsh ] && export SHELL=/bin/zsh


######################################################################
##### オプション設定                                             #####
##### 詳細は man zshoptions を参照                               #####
######################################################################

##### Change Directory

#setopt AUTO_CD
setopt AUTO_PUSHD
#setopt CDABLE_VALS
#setopt CHASE_DOTS
#setopt CHASE_LINKS
setopt PUSHD_IGNORE_DUPS
#setopt PUSHD_MINUS
#setopt PUSHD_SILENT
#setopt PUSHD_TO_HOME

##### 拡張・グロブ

#setopt BAD_PATTERN
#setopt BARE_GLOB_QUAL
setopt BRACE_CCL
#setopt CASE_GLOB
#setopt CSH_NULL_GLOB
setopt EQUALS
setopt EXTENDED_GLOB
#setopt GLOB
#setopt GLOB_ASSIGN
#setopt GLOB_DOTS
#setopt GLOB_SUBST
#setopt IGNORE_BRACES
#setopt KSH_GLOB
#setopt MAGIC_EQUAL_SUBST
#setopt MARK_DIRS
#setopt NOMATCH
#setopt NULL_GLOB
#setopt NUMERIC_GLOB_SORT
#setopt RC_EXPAND_PARAM
#setopt SH_GLOB
#setopt UNSET

##### 初期化

#setopt ALL_EXPORT
#setopt GLOBAL_EXPORT
#setopt GLOBAL_RCS
#setopt RCS

##### スクリプト・関数

#setopt C_BASES
#setopt ERR_EXIT
#setopt ERR_RETURN
#setopt EVAL_LINENO
#setopt EXEC
#setopt FUNCTION_ARGZERO
#setopt LOCAL_OPTIONS
#setopt LOCAL_TRAPS
#setopt MULTIOS
#setopt OCTAL_ZEROES
#setopt TYPESET_SILENT
#setopt VERBOSE
#setopt XTRACE

##### シェルエミュレーション

#setopt BSD_ECHO <S>
#setopt CSH_JUNKIE_HISTORY <C>
#setopt CSH_JUNKIE_LOOPS <C>
#setopt CSH_JUNKIE_QUOTES <C>
#setopt CSH_NULLCMD <C>
#setopt KSH_ARRAYS <K> <S>
#setopt KSH_AUTOLOAD <K> <S>
#setopt KSH_OPTION_PRINT <K>
#setopt KSH_TYPESET <K>
#setopt POSIX_BUILTINS <K> <S>
#setopt SH_FILE_EXPANSION <K> <S>
#setopt SH_NULLCMD <K> <S>
#setopt SH_OPTION_LETTERS <K> <S>
#setopt SH_WORD_SPLIT (-y) <K> <S>
#setopt TRAPS_ASYNC

##### シェルの状態

#setopt INTERACTIVE
#setopt LOGIN
#setopt PRIVILEGED
#setopt RESTRICTED
#setopt SHIN_STDIN
#setopt SINGLE_COMMAND

######################################################################
##### その他の環境変数                                           #####
######################################################################

##### JAVA_HOMEを書き換える (for msys2)
# バックスラッシュをスラッシュに置換
# ドライブレター (C:) をMSYS表記 (/c) に置き換え
JAVA_HOME=${${JAVA_HOME//\\//}/C://c}

##### jenv
if [ -d "$HOME/.jenv" ]; then
  export PATH=$HOME/.jenv/shims:$PATH
  source $HOME/.jenv/libexec/../completions/jenv.zsh
  jenv rehash 2>/dev/null
  export JENV_LOADED=1
  unset JAVA_HOME
  jenv() {
    typeset command
    command="$1"
    if [ "$#" -gt 0 ]; then
      shift
    fi

    case "$command" in
      enable-plugin|rehash|shell|shell-options)
        eval `jenv "sh-$command" "$@"`;;
      *)
        command jenv "$command" "$@";;
    esac
  }
fi

##### scalaenv
if [ -d "$HOME/.scalaenv" ]; then
  export PATH=$HOME/.scalaenv/shims:$PATH
  export SCALAENV_SHELL=zsh
  source $HOME/.scalaenv/libexec/../completions/scalaenv.zsh
  command scalaenv rehash 2>/dev/null
  scalaenv() {
    local command
    command="$1"
    if [ "$#" -gt 0 ]; then
      shift
    fi

    case "$command" in
      rehash|shell)
        eval "`scalaenv "sh-$command" "$@"`";;
      * )
        command scalaenv "$command" "$@";;
    esac
  }
fi

######################################################################
##### ホスト毎の設定                                             #####
######################################################################
[ -f $ZDOTDIR/.zshenv.$HOST ] && source $ZDOTDIR/.zshenv.$HOST

######################################################################
##### PATHの整理                                                 #####
######################################################################
alias PathContract="awk -f $ZDOTDIR/PathContract.awk"
PATH=`echo $PATH | PathContract`
LD_LIBRARY_PATH=`echo $LD_LIBRARY_PATH | PathContract`
PKG_CONFIG_PATH=`echo $PKG_CONFIG_PATH | PathContract`
CLASSPATH=`echo $CLASSPATH | PathContract`
unalias PathContract

# zsh

以下を ~/.bash_profile に追加する
-----
# 環境変数 SHELL を変更
if [ -z "$X_NOZSH" ]; then
  if [ -x /usr/bin/zsh ]; then
    SHELL=/usr/bin/zsh
  elif [ -x /bin/zsh ]; then
    SHELL=/bin/zsh
  fi
fi

if [ -f ~/.bashenv ]; then
    . ~/.bashenv
fi

# インタラクティブシェルかつログインシェルの場合のみ
# ~/.bashrc を明示的に読み込む
if [ ${-/i} != "$-" ]; then
    if [ "${0:0:1}" = "-" ]; then
        if [ -f ~/.bashrc ]; then
            . ~/.bashrc
        fi
    fi
fi
-----

以下を ~/.bashrc に追加する
-----
# インタラクティブシェルの場合は exec $SHELL を実行
# ログインシェルの場合は -l オプションを追加
if [ `basename $SHELL` == zsh ]; then
  if [ ${-/i} != "$-" ]; then
    if [ "${0:0:1}" = "-" ]; then
      exec -l $SHELL
    else
      exec $SHELL
    fi
  fi
fi
-----

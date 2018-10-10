# zsh

## Install

以下を ~/.bash_profile に追加する
    # 環境変数 SHELL を変更
    if [ -z "$X_NOZSH" ]; then
      if [ -x /usr/bin/zsh ]; then
        SHELL=/usr/bin/zsh
      elif [ -x /bin/zsh ]; then
        SHELL=/bin/zsh
      fi
    fi

    if [ -f "${HOME}/.bashenv" ]; then
      source ${HOME}/.bashenv
    fi

    # インタラクティブシェル ($- に 'i' が含まれる) かつ
    # ログインシェル ($0 が '-' で始まる) の場合のみ
    # ~/.bashrc を明示的に読み込む
    if [ ${-/i} != "$-" -a "${0:0:1}" = "-" ]; then
      if [ -f "${HOME}/.bashrc" ]; then
        source ${HOME}/.bashrc
      fi
    fi

以下を ~/.bashrc に追加する
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

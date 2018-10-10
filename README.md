# zsh

�ȉ��� ~/.bash_profile �ɒǉ�����
-----
# ���ϐ� SHELL ��ύX
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

# �C���^���N�e�B�u�V�F�������O�C���V�F���̏ꍇ�̂�
# ~/.bashrc �𖾎��I�ɓǂݍ���
if [ ${-/i} != "$-" ]; then
    if [ "${0:0:1}" = "-" ]; then
        if [ -f ~/.bashrc ]; then
            . ~/.bashrc
        fi
    fi
fi
-----

�ȉ��� ~/.bashrc �ɒǉ�����
-----
# �C���^���N�e�B�u�V�F���̏ꍇ�� exec $SHELL �����s
# ���O�C���V�F���̏ꍇ�� -l �I�v�V������ǉ�
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

# zsh

## Install

���O�C���V�F����zsh�ɂ���Ɩ�肪�N���邱�Ƃ�����D
�i����NIS/LDAP+NFS/Samba�ŃA�J�E���g��z�[���f�B���N�g�������L���Ă�����j
�Ȃ̂ŁC���O�C���V�F����bash�ɂ��Ă����C
bash�̏������X�N���v�g������zsh���N������悤�ɐݒ肷��D

�ȉ��� ~/.bash_profile �ɒǉ�����

    # ���ϐ� SHELL ��ύX
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

    # �C���^���N�e�B�u�V�F�� ($- �� 'i' ���܂܂��) ����
    # ���O�C���V�F�� ($0 �� '-' �Ŏn�܂�) �̏ꍇ�̂�
    # ~/.bashrc �𖾎��I�ɓǂݍ���
    if [ ${-/i} != "$-" -a "${0:0:1}" = "-" ]; then
      if [ -f "${HOME}/.bashrc" ]; then
        source ${HOME}/.bashrc
      fi
    fi

�ȉ��� ~/.bashrc �ɒǉ�����

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

#!/usr/bin/env bash

CONFIG_FILES=("aliases" "bash_completion" "bash_profile" "tmux.conf" "bash_prompt" "bashrc" "exports" "functions" "inputrc" "vimrc" "gitconfig" "gitignore")
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

function replace_dotfiles() {
  dotfiles=$1

  for f in ${dotfiles[*]}; do
    # 支持可重入，先删除原来的软链接
    dotfile="$HOME/.$f"
    if [ -L "$dotfile" ]; then
      rm -f "$dotfile"
    fi

    if [ -f "$dotfile" ]; then
      mv "$dotfile" "$dotfile"_bak
    fi

    # cp -f "$SCRIPT_DIR/$f" "$dotfile"
    ln -s "$SCRIPT_DIR/$f" "$dotfile"
  done
}

function main() {
  replace_dotfiles "${CONFIG_FILES[*]}"
  source ~/.bash_profile

  cur_system=$(uname -a)
  
  if [[ "$cur_system" == *"WSL"* ]]; then
    echo "WSL environment"
    PC_USER=pc
    WT_HOME="/mnt/c/Users/${PC_USER}/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState"
    cp -f wt_settings.json ${WT_HOME}/settings.json
    cp -f vimrc ~/_vimrc
    cp -f vimrc /mnt/c/Users/${PC_USER}/.ideavimrc
    cp -f gvimrc /mnt/c/Users/${PC_USER}/.gvimrc
  else
    echo "Linux environment"
  fi
}

main

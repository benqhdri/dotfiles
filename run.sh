#!/usr/bin/env bash

CONFIG_FILES=("aliases" "bash_profile" "bash_prompt" "bashrc" "exports" "functions" "gitconfig" "gitignore" "gvimrc" "inputrc" "path" "vimrc")
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

for f in ${CONFIG_FILES[*]}; do
  # 支持可重入，先删除原来的软链接
  dotfile="$HOME/.$f"
  if [ -L "$dotfile" ]
  then
    rm -f "$dotfile"
  fi

  if [ -f "$dotfile" ]
  then
    mv "$dotfile" "$dotfile"_bak
  fi
  ln -s "$SCRIPT_DIR/$f" "$dotfile"
done

# shellcheck disable=SC1090
source ~/.bash_profile
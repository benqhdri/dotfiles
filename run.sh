#!/usr/bin/env bash

CONFIG_FILES=("aliases" "bash_profile" "bash_prompt" "bashrc" "exports" "functions" "inputrc" "vimrc" "gitconfig" "gitignore" "gitmsg")
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

function create_soft_link() {
  dotfiles=$1

  for f in ${dotfiles[*]}; do
    # 支持可重入，先删除原来的软链接
    dotfile="$HOME/.$f"
    if [ -L "$dotfile" ]; then
      echo "soft link $f exists, remove it"
      rm -f "$dotfile"
    fi

    if [ -f "$dotfile" ]; then
      mv "$dotfile" "$dotfile"_bak
    fi

    ln -s "$SCRIPT_DIR/$f" "$dotfile"
  done
}

function main() {
  create_soft_link "${CONFIG_FILES[*]}"
  source ~/.bash_profile
}

main

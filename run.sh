config_files=("bashrc" "inputrc" "vimrc" "gitconfig" "gitignore" "gitmsg")

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

for f in ${config_files[*]}; do
  # 支持可重入，先删除原来的软链接
  dotfile="$HOME/.$f"
  if [ -L "$dotfile" ]
  then
    echo "soft link $f exists, remove it"
    rm -f "$dotfile"
  fi

  if [ -f "$dotfile" ]
  then
    mv "$dotfile" "$dotfile"_bak
  fi

  ln -s "$SCRIPT_DIR/$f" "$dotfile"
done
echo "create dotfile success"

system_info=$(uname)
wt_path="$LOCALAPPDATA/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json"

echo "system_info is $system_info"
if [[ "$system_info" =~ "CYGWIN" ]]; then
  echo "current system is windows"
  if [ -L "$wt_path" ]
  then
    echo "$wt_path exists, remove it"
    rm -f "$wt_path"
  fi

  if [ -f "$wt_path" ]
  then
    mv "$wt_path" "$wt_path"_bak
  fi

  cp -f "$SCRIPT_DIR/wt_settings.json" "$wt_path"
fi

bind -f ~/.inputrc
source ~/.bashrc
echo "activate dotfiles success"

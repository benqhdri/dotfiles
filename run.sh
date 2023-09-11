CONFIG_FILES=("tmux.conf" "aliases" "bash_profile" "bash_prompt" "bashrc" "bash_completion" "exports" "functions" "inputrc" "vimrc" "vim_plug" "gitconfig" "gitignore" "gitmsg")
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
NVIM_HOME="${HOME}/.config/nvim"

function create_soft_link() {
    destfile=$1
    dotfile=$2

    # if symbolic file exists, delete it first
    if [ -L "$dotfile" ]; then
        rm -f "$dotfile"
    fi

    # if real file exists, backup it
    if [ -f "$dotfile" ]; then
        mv "$dotfile" "$dotfile"_bak
    fi

    ln -s "${destfile}" "${dotfile}"
}

function main() {
    for f in ${CONFIG_FILES[*]}; do
        dst_file="${SCRIPT_DIR}/${f}"
        dot_file="${HOME}/.${f}"
        create_soft_link "${dst_file}" "${dot_file}"
    done

    # nvim config
    if [ ! -d "${NVIM_HOME}" ]; then
        mkdir -p "${NVIM_HOME}"
    fi
    create_soft_link "${SCRIPT_DIR}/init.vim" "${NVIM_HOME}/init.vim"

    if [[ $(uname -a) == *"microsoft"* ]]; then
        echo "WSL environment"
        username=$(cmd.exe /c echo %username% | sed -e "s/\r//g")
        echo "Current user is ${username}"

        wt_path="/mnt/c/Users/${username}/AppData/Local/Microsoft/Windows Terminal/settings.json"
        nvim_ginit_path="/mnt/c/Users/${username}/AppData/Local/nvim/ginit.vim"
        nvim_init_path="/mnt/c/Users/${username}/AppData/Local/nvim/init.vim"
        cp -f wt_settings.json "${wt_path}"
        cp -f init.vim "${nvim_init_path}"
        cp -f ginit.vim "${nvim_ginit_path}"
    fi

    source ~/.bash_profile
}

main

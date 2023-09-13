CONFIG_FILES=("tmux.conf" "aliases" "bash_profile" "bash_prompt" "bashrc" "bash_completion" "exports" "functions" "inputrc" "vimrc" "vim_plug" "gitconfig" "gitignore" "gitmsg")
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
NVIM_HOME="${HOME}/.config/nvim"
NVIM_SITE_HOME="${HOME}/.local/share/nvim/site/autoload"

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
    if [ ! -d "${NVIM_SITE_HOME}" ]; then
        mkdir -p "${NVIM_SITE_HOME}"
    fi
    create_soft_link "${SCRIPT_DIR}/init.vim" "${NVIM_HOME}/init.vim"
    cp -f "${SCRIPT_DIR}/plug.vim" "${NVIM_SITE_HOME}/plug.vim"

    if [[ $(uname -a) == *"microsoft"* ]]; then
        username=$(cmd.exe /c echo %username% | sed -e "s/\r//g")
        echo "WSL environment, user is ${username}"

        user_home="/mnt/c/Users/${username}"
        wt_path="${user_home}/AppData/Local/Microsoft/Windows Terminal/settings.json"
        qt_path="${user_home}/AppData/Local/nvim"
        qt_site_path="${user_home}/AppData/Local/nvim-data/site/autoload"
        ssh_path="${user_home}/.ssh"

        if [ ! -d "${qt_path}" ]; then
            mkdir -p "${qt_path}"
        fi
        if [ ! -d "${qt_site_path}" ]; then
            mkdir -p "${qt_site_path}"
        fi
        if [ ! -d "${ssh_path}" ]; then
            cp -fr "${HOME}/.ssh" "${ssh_path}"
        fi

        cp -f wt_settings.json "${wt_path}"
        cp -f init.vim "${qt_path}/init.vim"
        cp -f ginit.vim "${qt_path}/ginit.vim"
        cp -f plug.vim "${qt_site_path}/plug.vim"
    fi

    source ~/.bash_profile
}

main

if &term =~ "screen."
    let &t_ti.="\eP\e[2 q\e\\"
    let &t_SI.="\eP\e[6 q\e\\"
    let &t_EI.="\eP\e[2 q\e\\"
    let &t_te.="\eP\e[2 q\e\\"
else
    let &t_ti.="\<Esc>[2 q"
    let &t_SI.="\<Esc>[6 q"
    let &t_EI.="\<Esc>[2 q"
    let &t_te.="\<Esc>[2 q"
endif

" Auto commands
autocmd TextChanged,TextChangedI *.* if expand('%:e') != '1' && expand('%:e') != 'exe' | silent write | endif
autocmd FileType gitcommit,gitrebase,gitconfig set bufhidden=delete

nnoremap <silent>h :nohlsearch<CR>h
nnoremap <silent>j :nohlsearch<CR>j
nnoremap <silent>k :nohlsearch<CR>k
nnoremap <silent>l :nohlsearch<CR>l

let mapleader=" "                               " Set leader key to space
set nofoldenable                                " No default folding
set showmatch                                   " Go to match
set nu
set rnu
set linebreak
set scrolloff=10                                " Keep 10 lines when scrolling
set mouse=nv
" Change tab to space 4
set expandtab                                   " Change tab to space
set tabstop=4
set shiftwidth=4
set softtabstop=4
set foldmethod=indent

set ignorecase                                  " Ignore case
set smartcase                                   " Search upper case

set wildmode=longest,list                       " Auto completion

set timeout timeoutlen=1000 ttimeoutlen=100     " Fix slow O inserts
set lazyredraw
set history=8192                                " More history
set laststatus=2                                " Always show status line
set hidden                                      " Allow switching buffers without save
set clipboard=unnamed                           " Set vim to use system clipboard
set fileencodings=utf-8,gb18030                 " Support gbk format

" Not override the register when paste with viual mode
xnoremap p pgvy
nnoremap <C-g> :let @+=expand('%:p')<CR>:echo expand('%:p')<CR>

" Terminal settings
" set termwinscroll=100000                      " Old vim not support
nnoremap R y$pa<CR>

" Vim diff option
set diffopt=vertical

" Command mode mapping
cnoremap <expr> <C-p> wildmenumode() ? "\<C-p>" : "\<Up>"
cnoremap <expr> <C-n> wildmenumode() ? "\<C-n>" : "\<Down>"

" Buffer operations
nnoremap <C-p> :bp<CR>
nnoremap <C-n> :bn<CR>
nnoremap <leader>q :bp<bar>sp<bar>bn<bar>bd<CR>
nnoremap <leader>Q :%bd\|e#<CR>

" Window operations
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
tnoremap <C-h> <C-\><C-N><C-w>h
tnoremap <C-j> <C-\><C-N><C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
tnoremap <C-l> <C-\><C-N><C-w>l
inoremap <C-h> <C-\><C-N><C-w>h
inoremap <C-j> <C-\><C-N><C-w>j
inoremap <C-k> <C-\><C-N><C-w>k
inoremap <C-l> <C-\><C-N><C-w>l
nnoremap <A-c> :vs#<CR>

" Self-define functions
com! FormatJSON %!python -m json.tool
com! FormatPy %!python3 -m black - -q

" Local variables
let $WORK_DIR=getcwd()
let $LOCALFILE=expand("~/.vimrc_local")
if filereadable($LOCALFILE)
    source $LOCALFILE
endif

" Plug configs
if exists(':PlugInstall')
    source ~/.vimrc_plug
endif


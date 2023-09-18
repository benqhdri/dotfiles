" Auto commands
" autocmd TextChanged,TextChangedI *.* silent write
autocmd TextChanged,TextChangedI *.* if expand('%:e') != '1' && expand('%:e') != 'exe' | silent write | endif
autocmd FileType nerdtree noremap <buffer> <C-f> <nop>
autocmd FileType gitcommit,gitrebase,gitconfig set bufhidden=delete

let mapleader=" "                               " Set leader key to space
set nofoldenable                                " No default folding
set showmatch                                   " Go to match
set nu
set rnu
set linebreak
set scrolloff=10                                " Keep 10 lines when scrolling
set mouse=nv                                    " Enable mouse in normal and visual
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
set scrollback=100000                           " More terminal scroll back
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
nnoremap <C-c> <C-w>c
tnoremap <C-h> <C-\><C-N><C-w>h
tnoremap <C-j> <C-\><C-N><C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
tnoremap <C-l> <C-\><C-N><C-w>l
inoremap <C-h> <C-\><C-N><C-w>h
inoremap <C-j> <C-\><C-N><C-w>j
inoremap <C-k> <C-\><C-N><C-w>k
inoremap <C-l> <C-\><C-N><C-w>l
nnoremap <A-c> :vs#<CR>
nnoremap Q :only<CR>
tnoremap Q :only<CR>

" Set no highlight when esc
nnoremap <silent><Esc> :nohlsearch<CR><Esc>
vnoremap <silent><Esc> <Esc>:nohlsearch<CR><Esc>
inoremap <silent><Esc> <Esc>:nohlsearch<CR><Esc>

" Self-define functions
com! FormatJSON %!python -m json.tool
com! FormatPy %!python3 -m black - -q

" Local variables
let $WORK_DIR=getcwd()
let $LOCALFILE=expand("~/.vimrc_local")
if filereadable($LOCALFILE)
    source $LOCALFILE
endif

call plug#begin()
Plug 'preservim/nerdtree'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' }
Plug 'nvim-telescope/telescope-live-grep-args.nvim'
Plug 'itchyny/lightline.vim'
Plug 'ellisonleao/gruvbox.nvim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'ojroques/vim-oscyank', {'branch': 'main'}
Plug 'preservim/tagbar'
Plug 'mhartington/formatter.nvim'
Plug 'junegunn/vim-easy-align'
Plug 'rust-lang/rust.vim'
call plug#end()

" NERDTree
nnoremap <C-i> <C-i>
nnoremap <tab> :TagbarClose<CR>:NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
let NERDTreeMapOpenInTab='\t'
let NERDTreeMapOpenInTabSilent='\T'
let NERDTreeMapJumpParent='h'
let NERDTreeChDirMode=2 " change the working directory

" Lightline
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

" Tagbar
nnoremap t :NERDTreeClose<CR>:TagbarToggle<CR>
let tagbar_map_togglepause='\t'
let tagbar_map_previewwin='\p'
let tagbar_map_jump='P'
let g:tagbar_autofocus = 1
let g:tagbar_position = 'topleft vertical'
nnoremap ]w :call tagbar#jumpToNearbyTag(1, 'nearest')<CR>
nnoremap [w :call tagbar#jumpToNearbyTag(-1, 'nearest')<CR>

" Telescope
nnoremap <leader>f <cmd>Telescope find_files<cr>
nnoremap <leader>s <cmd>Telescope live_grep<cr>
nnoremap <leader>w <cmd>Telescope grep_string<cr>
nnoremap <leader>d <cmd>Telescope buffers<cr>
nnoremap <leader>h <cmd>Telescope help_tags<cr>

" OSCYank
nmap <leader>y <Plug>OSCYankOperator
nmap <leader>yy <leader>y_
nmap <leader>Y <leader>y$
vmap <leader>y <Plug>OSCYankVisual

" EasyAlign
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Git gutter
nmap ( <Plug>(GitGutterPrevHunk)
nmap ) <Plug>(GitGutterNextHunk)
nmap <Leader>u <Plug>(GitGutterUndoHunk)
nmap <Leader>v <Plug>(GitGutterPreviewHunk)
nnoremap <leader>b <cmd>Git blame<cr>

colorscheme gruvbox
" lua configuration
lua << EOF
require("telescope").setup({
  defaults = {
    layout_strategy = 'vertical',
    layout_config = {
      vertical = {
        preview_cutoff = 0,
      },
    },
  },
})
require("telescope").load_extension("live_grep_args")
EOF


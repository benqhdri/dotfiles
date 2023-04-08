" 自动保存
autocmd TextChanged,TextChangedI *.* silent write

" --- 基础设置
set nocompatible                                " 关闭兼容模式
set encoding=utf-8                              " 设置编码为utf-8

" --- 语法部分
syntax on                                       " 打开语法高亮
set showmatch                                   " 显示匹配的括号

filetype plugin indent on " enable file type detection

" set cursor shape
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" --- 编辑设置
set autoindent                                  " 自动缩进
set nu                                          " 行数
set rnu                                         " 相对行数
set incsearch                                   " 增量查找
set lbr                                         " 选择在合适的位置折行
set scrolloff=10                                " 滚动时保持上下五行
set nojoinspaces                                " 在两个单词之间不能输入两个空格
set backspace=indent,eol,start                  " backspace可用
" set mouse+=a                                    " 支持鼠标

" tab转换为4个空格
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
" 智能搜索
set ignorecase
set smartcase
" tab自动补全
set wildmode=longest,list
set wildmenu
" 一些不太懂的配置
set timeout timeoutlen=1000 ttimeoutlen=100 " fix slow O inserts
set lazyredraw " skip redrawing screen in some cases
set history=8192 " more history
set laststatus=2
set hidden

" --- 按键映射
nmap Q <Nop>                                    " 取消Q功能
map <C-x> <Nop>

vnoremap <C-c> "*y
nnoremap <C-a> ggVG
inoremap <NL> <ESC>A;<ESC>o
nnoremap <NL> A;<ESC>o

xnoremap p pgvy " 粘贴时不会覆写注册器

set clipboard=unnamed

" --- 支持本地配置
let $LOCALFILE=expand("~/.vimrc_local")
if filereadable($LOCALFILE)
    source $LOCALFILE
endif


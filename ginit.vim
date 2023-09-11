inoremap <silent> <S-Insert> <C-R>+
cnoremap <S-Insert> <C-R>"
tnoremap <S-Insert> <C-\><C-n>:put!+<CR>a

set guifont=Consolas:h14

" Full screen start
au GUIEnter * simalt ~x

" Makes bash open in the working directory
let $CHERE_INVOKING=1

" Paths will use / instead of \
set shellslash

lua << EOF
require('telescope').setup({
  defaults = {
    history = {path = "telescope_history"},
  },
})
EOF


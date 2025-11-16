" =====================
" === BASIC SETTINGS ===
" =====================

set number
set relativenumber

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

set incsearch
set termguicolors
set scrolloff=8
set updatetime=50

let mapleader = " "

" ======================
" === KEY MAPPINGS  ===
" ======================

" Quick quit and explorer
nnoremap <Esc> :q<CR>
nnoremap - :Ex<CR>
nnoremap <leader>pv :Ex<CR>

" Terminal toggle (Vim equivalent using split)
nnoremap <leader><A-t> :terminal<CR>

" Window movement and resizing
nnoremap <A-=> <C-w>+
nnoremap <A--> <C-w>-
nnoremap <A-[> <C-w>>
nnoremap <A-]> <C-w><
nnoremap <A-J> <C-w>J
nnoremap <A-K> <C-w>K
nnoremap <A-L> <C-w>L
nnoremap <A-H> <C-w>H
nnoremap <A-t> <C-w>t
nnoremap <A-d> <C-w>b
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
nnoremap <A-h> <C-w>h

" File explorers (open in split directions)
nnoremap <A-Left> :Vexplore<CR>
nnoremap <A-Up> :Sexplore<CR>
nnoremap <leader>pr :Rexplore<CR>
nnoremap <A-e> :only<CR>

nnoremap <leader>cd :cd %:h<CR>

" LazyGit equivalent if available
nnoremap <leader>lg :!lazygit<CR>

" Window switching
nnoremap <A-w> <C-w>w

" Insert mode escape
inoremap kj <Esc>
inoremap KJ <Esc>

" Move selected lines in visual mode
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Maintain center when jumping
nnoremap J mzJ`z
nnoremap <C-u> <C-u>zz
nnoremap <C-d> <C-d>zz
nnoremap n nzzzv

" Paste without overwriting
xnoremap <leader>p "_dP

" Yank to clipboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <C-c> "+y
vnoremap <C-c> "+y
nnoremap <leader>Y "+Y
nnoremap <leader>v :registers<CR>

" Replace word under cursor
nnoremap <leader><C-r> :%s/<C-r><C-w>//g<Left><Left>
vnoremap <C-r> :s/<C-r><C-w>//g<Left><Left>

" Tab management
nnoremap <leader>gt :tabn<CR>
nnoremap <leader>gr :tabp<CR>
nnoremap <leader>gn :tabnew ~/.vim<CR>
nnoremap <leader>gq :tabonly<CR>
nnoremap <leader><C-w> :tabclose<CR>

" Clear search highlight
nnoremap <leader>c :noh<CR>

" Diagnostic toggle — not supported in Vim; left as placeholder
" nnoremap gK :lua toggle_virtual_diagnostics()<CR>


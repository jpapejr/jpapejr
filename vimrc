if has('python3')
endif
set tabstop=4 softtabstop=0 expandtab shiftwidth=2 smarttab
set spelllang=en
set list
set listchars=tab:>-
syntax on
set background=dark
set autoindent
set smartindent
set hlsearch
set incsearch
set ignorecase
set smartcase
nnoremap Y y$
set magic
set number
set ruler
set backspace=indent,eol,start
set noswapfile
set autoread
filetype plugin on
set omnifunc=syntaxcomplete#Complete
set completeopt+=longest
set signcolumn=yes
nnoremap ; : 
nnoremap <silent><C-j> <C-w>j
nnoremap <silent><C-k> <C-w>k
nnoremap <silent><C-l> <C-w>l
nnoremap <silent><C-h> <C-w>h
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>
nmap <C-l> :Snippets<CR>
"set cc=80
filetype plugin indent on
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.vim/plugged')
Plug 'psf/black', { 'commit': 'ce14fa8b497bae2b50ec48b3bd7022573a59cdb1' }
Plug 'SirVer/ultisnips'
Plug 'sbdchd/neoformat'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'valloric/MatchTagAlways'
Plug 'honza/vim-snippets'
Plug 'epilande/vim-es2015-snippets'
Plug 'epilande/vim-react-snippets'
Plug 'leafgarland/typescript-vim'
"Plug 'tpope/vim-projectionist'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'Quramy/tsuquyomi', { 'do': 'npm -g install typescript' }
Plug 'sickill/vim-monokai'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'hashivim/vim-terraform'
Plug 'cwood/ultisnips-terraform-snippets'
Plug 'andrewstuart/vim-kubernetes'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'
call plug#end()
colorscheme monokai 
let g:jsx_ext_required = 0
let g:mta_filetypes = {
  \ 'javascript.jsx' : 1,
  \}
let g:prettier#exec_cmd_path="/usr/local/bin/prettier"

" Language Client settings
" Required for operations modifying multiple buffers like rename.
set hidden
set mouse=a

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

"make CoC windows easier to see
:highlight CocFloating ctermbg=darkgrey

" enhance clipboard interaction between remote ssh hosts and local Mac in iterm2
xnoremap <leader>c <esc>:'<,'>:w !~/.iterm2/it2copy<CR>

" NerdTree toggle
nnoremap <leader>n  :NERDTreeToggle<cr>
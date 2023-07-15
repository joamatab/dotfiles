" Vim Plug
call plug#begin('~/.vim/plugged')

" Autocomplete
Plug 'neoclide/coc.nvim', {'branch':'release'}
Plug 'fannheyward/coc-pyright'
" Plug 'davidhalter/jedi-vim'

" file browsing
Plug 'ptzz/lf.vim'
Plug 'voldikss/vim-floaterm'
" Plug 'rbgrouleff/bclose.vim'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-startify'
" Plug 'lvht/mru'
" Plug 'kien/ctrlp.vim'

" find
Plug 'justinmk/vim-sneak'
Plug 'dyng/ctrlsf.vim'
Plug 'majutsushi/tagbar'

" Document writing
Plug 'vimwiki/vimwiki'
Plug 'godlygeek/tabular', { 'for': 'markdown' }
" Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
" Plug 'masukomi/vim-markdown-folding', { 'for': 'markdown' }
" Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
" Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  } " If you have nodejs and yarn
Plug 'tmhedberg/SimpylFold'
Plug 'mbbill/undotree'
Plug 'gyim/vim-boxdraw'
" Plug 'jiangmiao/auto-pairs'
" Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
Plug 'junegunn/goyo.vim'
Plug 'cespare/vim-toml', { 'branch': 'main' }
Plug 'tpope/vim-repeat'

" Coding
Plug 'skywind3000/asyncrun.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'mattn/emmet-vim'
" Plug 'szymonmaszke/vimpyter' "jupyter-notebooks
" Plug 'jpalardy/vim-slime', { 'for': 'python' }
" Plug 'hanschen/vim-ipython-cell', { 'for': 'python' }
" Plug 'sillybun/vim-repl'
" Plug 'luiarthur/repl.vim'
" Plug 'junegunn/vim-emoji', { 'for': 'markdown' }
" Plug 'jupyter-vim/jupyter-vim'
" Plug 'goerz/jupytext'
Plug 'osyo-manga/vim-brightest'
" Plug 'neoclide/jsonc.vim'
Plug 'elzr/vim-json'
" Plug 'tpope/vim-sensible'
Plug 'dkarter/bullets.vim'

" Autoformat
Plug 'psf/black'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'Chiel92/vim-autoformat'
Plug 'sbdchd/neoformat'
" Plug 'prettier/vim-prettier'
" Plug 'prettier/vim-prettier', {
"             \ 'do': 'yarn install',
"             \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }

" Syntax check
Plug 'w0rp/ale'
Plug 'itspriddle/vim-shellcheck'
Plug 'dag/vim-fish', {'for':'fish'}

" Git help
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'airblade/vim-gitgutter'
" Plug 'jreybert/vimagit'
" Plug 'Xuyuanp/nerdtree-git-plugin'

" Font
Plug 'sjl/badwolf'
Plug 'ap/vim-css-color'
" Plug 'morhetz/gruvbox'
" Plug 'flazz/vim-colorschemes'
" Plug 'dag/vim-fish'
" Plug 'tomasr/molokai'
" Plug 'ajmwagar/vim-dues'
" Plug 'nanotech/jellybeans.vim'
call plug#end()

" Section: General
set nocompatible
if has("autocmd")
    filetype plugin indent on
endif

set hidden
set noerrorbells
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
" set smartindent
set nosmartindent
" set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch

set backspace=indent,eol,start
set modelines=1
" set showcmd             " show command in bottom bar
set ignorecase      " Ignore case in all searches...
set nocursorline        " highlight current line
set wildmenu
set lazyredraw
set showmatch           " higlight matching parenthesis
set fillchars+=vert:┃
set cursorline " gray line around the line
set nowritebackup
" set clipboard=unnamed
set clipboard+=unnamedplus
" set number              " show line numbers
" set relativenumber        " show line numbers

set tabstop=4           " 4 space tab
set expandtab           " use spaces for tabs
set softtabstop=4       " 4 space tab
" set autochdir           " set path to local dir
set splitbelow splitright " Splits open at the bottom and right

" nnoremap ; :
" xnoremap ; :
" xnoremap : ;

imap jj <ESC> " scape insert mode with `jj`
map <C-p> "+p
vnoremap <C-y> "*y :let @+=@*<CR>

" split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" nnoremap <Leader>+ :vertical resize +5<CR>
" nnoremap <Leader>- :vertical resize -5<CR>
nnoremap Y y$
nnoremap n nzzzv
nnoremap N Nzzzv

" line shortcuts
nnoremap j gj
nnoremap k gk
nnoremap gV `[v`]

" Replace all is aliased to S.
nnoremap S :%s//g<Left><Left>

" Return to the same line you left off at
augroup line_return
    au!
    au BufReadPost *
                \ if line("'\"") > 0 && line("'\"") <= line("$") |
                \   execute 'normal! g`"zvzz' |
                \ endif
augroup END


" Section: Colors
syntax enable           " enable syntax processing
colorscheme badwolf
" colorscheme gruvbox
" colorscheme jellybeans "default
"colorscheme molokai
"colorscheme solarized
"colorscheme zenburn
"set termguicolors
"call togglebg#map("<F5>")
" let g:gruvbox_italic=1
" highlight Comment term=bold ctermfg=white

" Toggle visibility of naughty characters
" Make naughty characters visible...
" (uBB is right double angle, uB7 is middle dot)
set lcs=tab:»·,trail:␣,nbsp:˷
highlight InvisibleSpaces ctermfg=Black ctermbg=Black
call matchadd('InvisibleSpaces', '\S\@<=\s\+\%#\ze\s*$', -10)

" Section: Leader
let mapleader="'"

" nnoremap <leader>r :call <SID>compile_and_run()<CR>

nmap <leader>2 :call <SID>compile_and_run()<CR>
nmap <leader>1 :wa<CR>:sp<CR>:resize 10<CR>:term ipython3 -i %<CR>
nmap <leader>y :TagbarToggle<CR>
nmap <leader>g :G<CR>
nmap <Leader>a <Plug>(Prettier)
" nmap <Leader>a :Autoformat<CR>
nmap <leader>o :Files<CR>
nmap <leader>O :Files!<CR>
nmap <leader>f :Files<CR>
nmap <leader>b :Buffers<CR>
nmap <leader>id :r!date "+\%F"<CR>
nmap <leader>j :History<CR>
nmap <leader>k :EnableAutocorrect<CR>
nmap <leader>t :tabe<CR>
nmap <leader>T :term<CR>
nmap <leader>N :NERDTreeToggle<CR>
nmap <leader>" :bp<CR>
nmap <leader>' :bn<CR>
nmap <leader>p :bp<CR>
nmap <leader>q :q <CR>
nmap <leader>w :wa <CR>
nmap <leader>- :vsplit<CR>
nmap <leader>_ :split<CR>
nmap <leader>z :wa<CR>:q<CR>
map <leader>cfv :vi ~/.config/nvim/init.vim<CR>
vnoremap <leader>s :sort<CR>
nmap <leader>v :call PasteClipboardImage()<CR>
map <leader>l :Lf<CR>
nnoremap <leader>u :UndotreeToggle<CR>

nmap <leader>ga :Gwrite<CR>
nmap <leader>gw :Gwrite<CR>
nmap <leader>gs :Git<CR>
nmap <leader>gc :Git commit -v -a<CR>
nmap <leader>gb :Gblame<CR>
nmap <leader>gd :Gdiffsplit<CR>
nmap <leader>gp :Git push<CR>
nmap <leader>gf :diffget //2<CR>
nmap <leader>gj :diffget //3<CR>
nmap <leader>sv :w!<CR>:source ~/.config/nvim/init.vim<CR>
" nmap <leader>m :Mru<CR>
" nnoremap <leader>gp :call <SID>push()<CR>
" nnoremap <leader>gl :call <SID>pull()<CR>

" Bullets.vim
let g:bullets_enabled_file_types = [
    \ 'yaml',
    \ 'markdown',
    \ 'text',
    \ 'gitcommit',
    \ 'scratch'
    \]

" spell chech
map <leader>ss :setlocal spell!<CR>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>sf z=

map <leader>n :set rnu!<CR>

vnoremap < <gv
vnoremap > >gv
vnoremap - :s/\%V /_/g

let g:lf_map_keys = 0

" Section: Functions
function! s:compile_and_run()
    exec 'wa'
    if &filetype == 'c'
        exec "AsyncRun! gcc % -o %<; time ./%<"
    elseif &filetype == 'cpp'
        exec "AsyncRun! g++ -std=c++11 % -o %<; time ./%<"
    elseif &filetype == 'java'
        exec "AsyncRun! javac %; time java %<"
    elseif &filetype == 'sh'
        exec "AsyncRun! time bash %"
    elseif &filetype == 'fish'
        exec "AsyncRun! time fish %"
    elseif &filetype == 'python'
        " exec "AsyncRun! time python %"
        " exec "AsyncRun -raw python %"
        " exec "AsyncRun -raw ipython3 -i %"
        exec "term ipython3 -i %"
	    " exec "AsyncRun -raw wa<cr>sp<cr>term ipython3 -i %"
	    " set wa<cr>set sp<cr>set term ipython3 -i %
    endif
endfunction

function! s:push()
    exec 'w'
    " exec "AsyncRun! git add .; git commit -a -m 'vim autocommit' > /dev/null; git push > /dev/null& "
    exec "AsyncRun! git add .; git commit -a -q -m 'vim autocommit'; git push -q"
endfunction

function! s:pull()
    exec 'w'
    exec "AsyncRun! git pull -q"
endfunction

" asyncrun now has an option for opening quickfix automatically
let g:asyncrun_open = 5
let $PYTHONUNBUFFERED=1
" }}}

function! PasteClipboardImage() abort
    " Create `img` directory if it doesn't exist
    let img_dir = getcwd() . '/images'
    let img_path = 'images'
    if !isdirectory(img_dir)
        silent call mkdir(img_dir)
    endif

    let index = strftime("%y%m%d%H%M%S")
    let file_path = img_dir . "/" . index . ".png"

    let file_relative_path = "images/" . index . ".png"
    let clip_command = 'osascript'
    let clip_command .= ' -e "set png_data to the clipboard as «class PNGf»"'
    let clip_command .= ' -e "set referenceNumber to open for access POSIX path of'
    let clip_command .= ' (POSIX file \"' . file_path . '\") with write permission"'
    let clip_command .= ' -e "write png_data to referenceNumber"'

    silent call system(clip_command)

    if v:shell_error == 1
        normal! p
    elseif &filetype == 'rst'
        exec "normal! i.. image:: " . file_relative_path
    else
        exec "normal! i![](" . file_relative_path . ")"
    endif
endfunction

function! DoPrettyXML()
  " save the filetype so we can restore it later
  let l:origft = &ft
  set ft=
  " delete the xml header if it exists. This will
  " permit us to surround the document with fake tags
  " without creating invalid xml.
  1s/<?xml .*?>//e
  " insert fake tags around the entire document.
  " This will permit us to pretty-format excerpts of
  " XML that may contain multiple top-level elements.
  0put ='<PrettyXML>'
  $put ='</PrettyXML>'
  silent %!xmllint --format -
  " xmllint will insert an <?xml?> header. it's easy enough to delete
  " if you don't want it.
  " delete the fake tags
  2d
  $d
  " restore the 'normal' indentation, which is one extra level
  " too deep due to the extra tags we wrapped around the document.
  silent %<
  " back to home
  1
  " restore the filetype
  exe "set ft=" . l:origft
endfunction
command! PrettyXML call DoPrettyXML()

" FZF from https://github.com/jeremyckahn/vim-docker-env
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --glob "!.git/*"'
nmap // :BLines!<CR>
nmap ?? :Rg!<CR>
nmap cc :Commands!<CR>

" jupyter vim
" let g:jupyter_mapkeys = 0

" Section: Nerdtree
let g:NERDTreeWinPos = "right"
let NERDTreeShowHidden=0
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
let g:NERDTreeWinSize=35

" Section: FileType
augroup configgroup
    autocmd!
    autocmd VimEnter * highlight clear SignColumn
    autocmd BufEnter *.cls setlocal filetype=java
    autocmd BufEnter *.zsh-theme setlocal filetype=zsh
    autocmd BufEnter Makefile setlocal noexpandtab
    autocmd BufEnter *.sh setlocal tabstop=2
    autocmd BufEnter *.sh setlocal shiftwidth=2
    autocmd BufEnter *.sh setlocal softtabstop=2
    autocmd BufEnter *.py setlocal tabstop=4
    autocmd BufEnter *.lsf setlocal filetype=python
    autocmd BufEnter *.ipynb setlocal filetype=python
    autocmd BufEnter *.lyrdb setlocal filetype=python
    autocmd BufEnter *.lym setlocal filetype=python
    autocmd BufEnter *.rss setlocal filetype=xml
    autocmd BufEnter *.md setlocal ft=markdown
    autocmd BufEnter *.pyxs setlocal ft=python
    autocmd FileType python nnoremap <buffer><silent><leader>a :Black<CR>
	autocmd FileType python nnoremap <buffer> <cr> :silent wa<bar>only<bar>vsp<bar>term ipython3 -i %<cr>
augroup END


" Section: python
set suffixesadd=.py
set wildignore=*.pyc,*/__pycache__/*
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*
set wildignore+=*.swp,*~,._*
set wildignore+=term*
let g:netrw_list_hide= '.*\.pyc$'

let $NVIM_PYTHON_LOG_FILE="/tmp/nvim_log"
let $NVIM_PYTHON_LOG_LEVEL="DEBUG"
" let g:python_host_prog='/usr/local/bin/python'
" let g:python3_host_prog='/usr/local/bin/python'
" let g:python3_host_prog = expand('~/.config/nvim/env/bin/python')
" let g:python3_host_prog = expand('~/.pyenv/versions/3.7.8/bin/python')

set completefunc=emoji#complete

" Section: Folding
" set foldmethod=syntax
set foldmethod=indent   " fold based on indent level
set foldnestmax=10      " max 10 depth
set foldenable          " don't fold files by default on open
set foldlevelstart=10   " start with fold level of 1
nnoremap <space> za


" Section: VimWiki
let g:vimwiki_list = [
            \ {'path': '~/wikis/joaquin/', 'path_html': '~/wikis/html', 'syntax': 'markdown', 'ext': '.md'},
            \ {'path': '~/wikis/github/', 'path_html': '~/wikis/html', 'syntax': 'markdown', 'ext': '.md'},
            \ {'path': '~/wikis/gotbletu', 'path_html': '~/wikis/html', 'syntax': 'markdown', 'ext': '.md'},
            \ {'path': '~/wikis/book-notes', 'path_html': '~/wikis/html', 'syntax': 'markdown', 'ext': '.md'},
            \ ]

" Section: Markdown
" let g:vim_markdown_new_list_item_indent = 0
" let g:vim_markdown_auto_insert_bullets = 0
" let g:vim_markdown_autowrite = 1

" Section: ALE
" Enable completion where available.
" Check Python files with flake8 and pylint.
" Fix Python files with autopep8 and yapf.
" let g:ale_completion_enabled = 1
" let b:ale_linters = ['flake8', 'pylint']
" let b:ale_fixers = ['autopep8', 'yapf']
" Disable warnings about trailing whitespace for Python files.
" let b:ale_warn_about_trailing_whitespace = 0
" let g:ale_linters = {'rust': ['cargo', 'rls'], 'javascript': ['eslint', 'flow'], 'python': ['flake8', 'mypy']}
" let g:ale_linters = {'rust': ['cargo', 'rls'], 'javascript': ['eslint', 'flow'], 'python': ['flake8', 'pylint']}
" let g:ale_fixers = {'json': ['jq'], 'rust': ['rustfmt'], 'javascript': ['prettier'], 'css': ['prettier'], 'python': ['black', 'isort', 'remove_trailing_lines', 'trim_whitespace']}
" let g:ale_fixers.markdown = ['remark']
" let g:ale_fixers.markdown = ['prettier', 'remark']
" let g:ale_fixers = {}
" let g:ale_fixers.python = ['black']
" let g:ale_linters = { "python": ["ruff", 'pylint', 'mypy'] }
let g:ale_linters = { "python": ["ruff"] }
let g:ale_fixers = {
\       "python": ["black", "ruff"],
\}

" Section: Abbreviations
iab ifp from functools import partial
iab ikf import kfactory as kf
iab igf import gdsfactory as gf
iab igc import gdsfactory.components as gc
iab inp import numpy as np
iab iplt import matplotlib.pyplot as plt
iab ipd import pandas as pd
iab ipdb import ipdb; ipdb.set_trace()
iab pdb import pdb; pdb.set_trace()
iab ifmain if __name__ == "__main__":
iab heigth height
iab teh the
iab retrun return
iab previosu previous
iab Wb wb
iab plts plt.style.use('seaborn-whitegrid')


" CtrlSF
" substitute the word under the cursor
nmap <leader>S :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>
nmap <leader>/ :CtrlSF -R ""<Left>
nmap <leader>c :CtrlSFFocus<CR>
nmap <leader>C :CtrlSFToggle<CR>
let g:ctrlsf_ackprg = '/usr/bin/rg'

" Sneak
let g:sneak#label = 1

" CoC
let g:coc_global_extensions = [
  \ 'coc-css',
  \ 'coc-json',
  \ 'coc-tsserver',
  \ 'coc-tailwindcss',
  \ 'coc-elixir',
  \ 'coc-svelte',
  \ 'coc-html',
  \ 'coc-yaml',
  \ 'coc-vimlsp',
  \ 'coc-svg',
  \ 'coc-actions',
  \ 'coc-lists',
  \ 'coc-json',
  \ 'coc-yank',
  \ 'coc-highlight',
  \ 'coc-solargraph',
  \ 'coc-pyright',
  \ ]
nnoremap <silent> <leader>h :CocCommand document.toggleInlayHint<cr>
nnoremap <silent> <leader>cl :CocDiagnostics<cr>
nnoremap <silent> <leader>cp :Copilot <cr>
nnoremap <silent> <leader>ch :call CocAction('doHover')<cr>
nnoremap <silent> <leader>cf <plug>(coc-codeaction-cursor)
nnoremap <silent> <leader>ca <plug>(coc-fix-current)
" nmap <silent> gd :call CocActionAsync('jumpDefinition')<cr>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> <leader>d <Plug>(coc-definition)

nmap <silent> <leader>D <Plug>(coc-declaration)
nmap <silent> <leader>r <Plug>(coc-rename)
nmap <silent> <leader>R <Plug>(coc-refactor)

nmap <silent> [c <plug>(coc-diagnostic-prev)
nmap <silent> ]c <plug>(coc-diagnostic-next)

" diagrams
set virtualedit+=all

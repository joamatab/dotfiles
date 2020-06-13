" Section: Vim Plug
call plug#begin('~/.vim/plugged')

Plug 'Shougo/deoplete.nvim'
" Plug 'kiteco/vim-plugin', { 'for': 'python' }
" Plug 'neoclide/coc.nvim', {'branch':'release'}

" file browsing
Plug 'ptzz/lf.vim'
Plug 'rbgrouleff/bclose.vim'
Plug 'lvht/mru'
Plug 'kien/ctrlp.vim'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Document writing
Plug 'vimwiki/vimwiki'
Plug 'godlygeek/tabular', { 'for': 'markdown' }
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'masukomi/vim-markdown-folding', { 'for': 'markdown' }
Plug 'mbbill/undotree'
" Plug 'junegunn/vim-emoji', { 'for': 'markdown' }

" Coding
Plug 'ambv/black'
Plug 'skywind3000/asyncrun.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'w0rp/ale', {'for':'python'}
Plug 'dag/vim-fish', {'for':'fish'}
Plug 'itspriddle/vim-shellcheck'
Plug 'szymonmaszke/vimpyter' "vim-plug
Plug 'jupyter-vim/jupyter-vim'
" Plug 'goerz/jupytext'

" Autoformat
Plug 'Chiel92/vim-autoformat'
" Plug 'prettier/vim-prettier'
Plug 'prettier/vim-prettier', {
            \ 'do': 'yarn install',
            \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }

" Git help
Plug 'tpope/vim-fugitive'
" Plug 'jreybert/vimagit'
" Plug 'airblade/vim-gitgutter'
" Plug 'Xuyuanp/nerdtree-git-plugin'

" Font
Plug 'sjl/badwolf'
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
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nowrap
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
let g:deoplete#enable_at_startup = 1
set cursorline " gray line around the line
set nobackup
set nowritebackup
set noswapfile
" set number              " show line numbers

set tabstop=4           " 4 space tab
set expandtab           " use spaces for tabs
set softtabstop=4       " 4 space tab
set autochdir           " set path to local dir
imap jj <ESC> " scape insert mode with `jj`
map <C-p> "+p
vnoremap <C-y> "*y :let @+=@*<CR>
set splitbelow splitright " Splits open at the bottom and right

" split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

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
"colorscheme jellybeans "default
"colorscheme molokai
"colorscheme solarized
"colorscheme zenburn
"set termguicolors
"call togglebg#map("<F5>")
highlight Comment term=bold ctermfg=white

" Toggle visibility of naughty characters
" Make naughty characters visible...
" (uBB is right double angle, uB7 is middle dot)
set lcs=tab:»·,trail:␣,nbsp:˷
highlight InvisibleSpaces ctermfg=Black ctermbg=Black
call matchadd('InvisibleSpaces', '\S\@<=\s\+\%#\ze\s*$', -10)

" Section: Leader
let mapleader="'"

map <leader>g :G<CR>
nmap <Leader>p <Plug>(Prettier)
nnoremap <F9> :Black<CR>
map <leader>f :Files<CR>
nmap <Leader>a :Autoformat<CR>
nmap <leader>d :r!date "+\%F"<CR>
nmap <leader>j :CtrlPMRUFiles<CR>
nmap <leader>k :EnableAutocorrect<CR>
nmap <leader>m :Mru<CR>
nmap <leader>t :NERDTreeToggle<CR>
nmap <leader>n :bn<CR>
nmap <leader>q :q <CR>
nmap <leader>w :w <CR>
nmap <leader>x :split<CR>
nmap <leader>z :wq <CR>
nmap <leader>c :Gwrite <CR>
nmap <leader>sv :w!<CR>:source ~/.config/nvim/init.vim<CR>
map <leader>cfv :vi ~/.config/nvim/init.vim<CR>
vnoremap <leader>s :sort<CR>
nnoremap <leader>r :call <SID>compile_and_run()<CR>
nnoremap <leader>ap :call <SID>push()<CR>
nnoremap <leader>al :call <SID>pull()<CR>
nmap <leader>v :call PasteClipboardImage()<CR>
map <leader>l :Lf<CR>
nnoremap <leader>u :UndotreeToggle<CR>

nmap <leader>gf :diffget //2<CR>
nmap <leader>gj :diffget //3<CR>

" spell chech
map <leader>ss :setlocal spell!<CR>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>sf z=

vnoremap < <gv
vnoremap > >gv


let g:lf_map_keys = 0

" Section: Functions
function! s:compile_and_run()
    exec 'w'
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
        exec "AsyncRun -raw python %"
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


" jupyter vim
let g:jupyter_mapkeys = 0

" Section: CTL+P
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_custom_ignore = '\vbuild/|dist/|venv/|target/|\.(o|swp|pyc|egg)$'
let g:ctrlp_max_height = 20
let g:ctrlp_working_path_mode = 'ra'

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
    autocmd BufEnter *.rss setlocal filetype=xml
    autocmd BufEnter *.md setlocal ft=markdown
    autocmd FileType python nnoremap <buffer><silent><leader>p :Black<CR>
augroup END


" Section: python
set suffixesadd=.py
set wildignore=*.pyc
let g:netrw_list_hide= '.*\.pyc$'

let $NVIM_PYTHON_LOG_FILE="/tmp/nvim_log"
let $NVIM_PYTHON_LOG_LEVEL="DEBUG"
let g:python_host_prog='/usr/local/bin/python'
let g:python3_host_prog='/usr/local/bin/python'

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
            \ {'path': '~/wikis/go', 'path_html': '~/wikis/html', 'syntax': 'markdown', 'ext': '.md'},
            \ {'path': '~/wikis/joaquin/', 'path_html': '~/wikis/html', 'syntax': 'markdown', 'ext': '.md'},
            \ {'path': '~/wikis/github/', 'path_html': '~/wikis/html', 'syntax': 'markdown', 'ext': '.md'},
            \ {'path': '~/wikis/gotbletu', 'path_html': '~/wikis/html', 'syntax': 'markdown', 'ext': '.md'},
            \ ]


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
let g:ale_linters = {'rust': ['cargo', 'rls'], 'javascript': ['eslint', 'flow'], 'python': ['flake8', 'pylint']}
let g:ale_fixers = {'json': ['jq'], 'rust': ['rustfmt'], 'javascript': ['prettier'], 'css': ['prettier'], 'python': ['yapf', 'isort', 'remove_trailing_lines', 'trim_whitespace']}
let g:ale_fixers.markdown = ['prettier', 'remark']

" Section: Abbreviations
iab ipdb import ipdb; ipdb.set_trace()
iab pdb import pdb; pdb.set_trace()
iab ifmain if __name__ == "__main__":
iab heigth height
iab teh the
iab retrun return
iab previosu previous
iab Wb wb

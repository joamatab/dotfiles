" ~/.vimrc
" Section: Vim Plug 
call plug#begin('~/.vim/plugged')

" if has('nvim')
"   Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"   " Plug 'zxqfl/tabnine-vim'
"   " Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }
" else
"   Plug 'Shougo/deoplete.nvim'
"   Plug 'roxma/nvim-yarp'
"   Plug 'roxma/vim-hug-neovim-rpc'
" endif
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins', 'for': 'markdown'}
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
" Plug 'junegunn/vim-emoji', { 'for': 'markdown' }

" Coding
Plug 'skywind3000/asyncrun.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'w0rp/ale', {'for':'python'}
Plug 'dag/vim-fish', {'for':'fish'}
Plug 'szymonmaszke/vimpyter' "vim-plug
" Plug 'goerz/jupytext'

" Autoformat
Plug 'ambv/black'
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
set pastetoggle=<F2> " toggles between ```set paste``` and ```set nopaste```
set backspace=indent,eol,start
set shiftwidth=4
set modelines=1
set autoindent                              "Retain indentation on next line
set smartindent                             "Turn on autoindenting of blocks
" set showcmd             " show command in bottom bar
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
        \	execute 'normal! g`"zvzz' |
        \ endif
augroup END


" luke
" set laststatus=1
" set nohlsearch
" set clipboard=unnamedplus
" Enable autocompletion:
" set wildmode=longest,full
" Disables automatic commenting on newline:
" autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

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
" nmap <leader>a :w!<cr>:!python % <bar> cat<cr>
" nmap <leader>e :w!<cr>:!fish run.sh cat<cr>
" nmap <leader>p :AsyncRun gp<cr>
" nmap <leader>r  :w!<cr> :Ranger<CR>
nmap <Leader>t <Plug>(Prettier)
nmap <leader>l :Black<cr>
map <leader>b :Buffers<cr>
map <leader>g :GFiles<cr>
map <leader>f :Files<cr>
map <leader>e :set foldmethod=expr<cr>
" nnoremap <F2> <Plug>(coc-rename)

nmap <Leader>a :Autoformat<cr>
nmap <leader>d :r!date "+\%F"<CR>
nmap <leader>j :CtrlPMRUFiles<cr>
nmap <leader>k :EnableAutocorrect<cr>
nmap <leader>m :Mru<CR>
nmap <leader>n :NERDTreeToggle<cr>
nmap <leader>q :q <cr>
nmap <leader>sv :w!<cr>:source ~/.vimrc<CR>
nmap <leader>w :w <cr>
nmap <leader>x :split<cr>
nmap <leader>z :wq <cr>
nmap <leader>c :Gwrite <cr>
map <leader>cfv :vi ~/.vimrc<CR>
map <leader>wu :vi ~/wikis/psi/updates_joaquin.md<CR>
vnoremap <leader>s :sort<cr>

" autocmd Filetype ipynb nmap <silent><Leader>vb :VimpyterInsertPythonBlock<CR>
" autocmd Filetype ipynb nmap <silent><Leader>vj :VimpyterStartJupyter<CR>
" autocmd Filetype ipynb nmap <silent><Leader>vn :VimpyterStartNteract<CR>

" map <leader>f :Neoformat<cr>
" nnoremap t :silent %!prettier --stdin --stdin-filepath % --trailing-comma all --single-quote<CR>
" map <leader>t :Tags<cr>
" map <leader>k :Calendar<CR>
" map <leader>c :w! \| !compiler <c-r>%<CR><CR>
" nmap <leader>sw :w !sudo tee % > /dev/null<CR>
" nmap <leader>t :terminal <cr>

" nmap <leader>n :tabnext<cr>
" nmap <leader>e :w!<cr>:tabe %:p:h<cr>
vnoremap < <gv
vnoremap > >gv
" nnoremap <silent><buffer><expr> <C-s> :split<CR>
" nnoremap <silent><buffer><expr> <C-v> :vsplit<CR>

"nmap <leader>i :!/usr/local/bin/ipython -i  <cr> 
"nnoremap <leader>m :silent make\|redraw!\|cw<CR>
"nnoremap <leader>h :A<CR>
"nnoremap <leader>ev :vsp $MYVIMRC<CR>
"nnoremap <leader>et :exec ":vsp /Users/dblack/notes/vim/" . strftime('%m-%d-%y') . ".md"<CR>
"nnoremap <leader>ez :vsp ~/.zshrc<CR>
"nnoremap <leader>l :call ToggleNumber()<CR>
"nnoremap <leader><space> :noh<CR>
"nnoremap <leader>s :mksession<CR>
"nnoremap <leader>a :Ag 
"nnoremap <leader>c :SyntasticCheck<CR>:Errors<CR>
"nnoremap <leader>1 :set number!<CR>
"nnoremap <leader>d :Make! 
"nnoremap <leader>r :TestFile<CR>
"nnoremap <leader>g :call RunGoFile()<CR>
"vnoremap <leader>y "+y

" Section: async Run 
nnoremap <leader>r :call <SID>compile_and_run()<CR>
nnoremap <leader>ap :call <SID>push()<CR>
nnoremap <leader>al :call <SID>pull()<CR>

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

" augroup SPACEVIM_ASYNCRUN
"     autocmd!
"    " Automatically open the quickfix window
"     autocmd User AsyncRunStart call asyncrun#quickfix_toggle(15, 1)
" augroup END
"
" asyncrun now has an option for opening quickfix automatically
let g:asyncrun_open = 5
let $PYTHONUNBUFFERED=1
" }}}

" Section: Paste images from clipboard 
nmap <leader>p :call PasteClipboardImage()<cr>

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


" Section: Search
" set incsearch       " search as characters are entered
set ignorecase      " Ignore case in all searches...
set smartcase       " unless uppercase letters used

set hlsearch        " highlight all matches
highlight clear Search
highlight       Search    ctermfg=White  ctermbg=Black  cterm=bold
highlight    IncSearch    ctermfg=White  ctermbg=Red    cterm=bold

" persistent_undo {{{
if has('persistent_undo')
    " Save all undo files in a single location (less messy, more risky)...
    set undodir=$HOME/.VIM_UNDO_FILES

    " Save a lot of back-history...
    set undolevels=5000

    " Actually switch on persistent undo
    set undofile
end

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
augroup END

" Backups 
" set backup
" set backupdir=~/.vim/backup
" set backupskip=/tmp/*,/private/tmp/*
" set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
" set writebackup
" silent execute '!mkdir _backupdir'

" spell chech
map <leader>ss :setlocal spell!<cr>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

" Section: python
" let g:pymode_python = 'python'
" let g:pymode_virtualenv = 1
" let g:pymode_virtualenv_path = $VIRTUAL_ENV
" let g:pymode_rope_lookup_project = 0
" let g:pymode_rope_complete_on_dot = 0
" let g:pymode_rope = 0
set suffixesadd=.py
set wildignore=*.pyc
let g:netrw_list_hide= '.*\.pyc$'
" autocmd BufWritePre *.py execute ':Black'

let $NVIM_PYTHON_LOG_FILE="/tmp/nvim_log"
let $NVIM_PYTHON_LOG_LEVEL="DEBUG"
let g:python_host_prog='/usr/local/bin/python'
let g:python3_host_prog='/usr/local/bin/python'

" Section: Markdown
let g:vim_markdown_math = 1
let g:vim_markdown_autowrite = 1
let vim_markdown_preview_toggle=1
let vim_markdown_preview_browser='Google Chrome'
let g:mkdp_browser = 'Google Chrome'
let g:vim_markdown_no_extensions_in_markdown = 1
let g:vim_markdown_auto_insert_bullets = 1
" let g:vim_markdown_folding_style_pythonic = 1

set completefunc=emoji#complete

" Section: Folding
" set foldmethod=syntax
set foldmethod=indent   " fold based on indent level
set foldnestmax=10      " max 10 depth
set foldenable          " don't fold files by default on open
set foldlevelstart=10   " start with fold level of 1
nnoremap <space> za

" COC
let g:coc_global_extensions = [
    \ 'coc-snippets',
    \ 'coc-pairs',
    \ 'coc-tsserver',
    \ 'coc-html',
    \ 'coc-css',
    \ 'coc-prettier',
    \ 'coc-json',
    \ 'coc-angular',
    \ 'coc-vimtex',
    \ 'coc-omnisharp'
    \ ]


" Section: VimWiki
let g:vimwiki_list = [
\ {'path': '~/wikis/go', 'path_html': '~/public_html/vimwiki/HouseholdWiki', 'syntax': 'markdown', 'ext': '.md'},
\ {'path': '~/wikis/joaquin/', 'path_html': '~/public_html/vimwiki/PersonalWiki', 'syntax': 'markdown', 'ext': '.md'},
\ {'path': '~/wikis/github/', 'path_html': '~/public_html/vimwiki/HouseholdWiki', 'syntax': 'markdown', 'ext': '.md'},
\ {'path': '~/wikis/gotbletu', 'path_html': '~/public_html/vimwiki/HouseholdWiki', 'syntax': 'markdown', 'ext': '.md'},
\ ]

"" set preferred settings
" let vimwiki_folding='syntax'
" let g:vimwiki_folding='list'
" autocmd FileType vimwiki setlocal tabstop=4 expandtab

" Section: Calendar
let g:calendar_google_calendar = 1
let g:calendar_google_task = 1

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


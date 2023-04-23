" leader

nnoremap <F9> :Black<CR>
map <leader>b :buffers<CR>
nnoremap <F2> <Plug>(coc-rename)
nmap <leader>a :w!<CR>:!python % <bar> cat<cr>
nmap <leader>e :w!<CR>:!fish run.sh cat<CR>
nmap <leader>p :AsyncRun gp<CR>
nmap <leader>r  :w!<CR> :Ranger<CR>
map <leader>g :GFiles<CR>
nmap <leader>l :Black<CR>
map <leader>e :set foldmethod=expr<CR>

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

"" set preferred settings
" let vimwiki_folding='syntax'
" let g:vimwiki_folding='list'
" autocmd FileType vimwiki setlocal tabstop=4 expandtab

" Section: Calendar
let g:calendar_google_calendar = 1
let g:calendar_google_task = 1

" Section: python
" let g:pymode_python = 'python'
" let g:pymode_virtualenv = 1
" let g:pymode_virtualenv_path = $VIRTUAL_ENV
" let g:pymode_rope_lookup_project = 0
" let g:pymode_rope_complete_on_dot = 0
" let g:pymode_rope = 0
" autocmd BufWritePre *.py execute ':Black'


" let g:python3_host_prog="/Users/joaquin/miniconda3/bin/python3"
" let g:python_host_prog='/Users/joaquin/anaconda3/bin/python'
" let g:python3_host_prog='/Users/joaquin/anaconda3/bin/python'
" nnoremap S :keeppatterns substitute/\s*\%#\s*/\r/e <bar> normal! ==<CR>
let $NVIM_PYTHON_LOG_FILE="/tmp/nvim_log"
let $NVIM_PYTHON_LOG_LEVEL="DEBUG"


" I'm sick of typing :%s/.../.../g
" Nmap S  [Shortcut for :s///g]  :%s//g<LEFT><LEFT>
" xmap S                         :s//g<LEFT><LEFT>
" Nmap <expr> M  [<leader>aShortcut for :s/<last match>//g]  ':%s/' . @/ . '//g<LEFT><LEFT>'
" xmap <expr> M                                     ':s/' . @/ . '//g<LEFT><LEFT>'

autocmd BufWritePre *.php,*.py,*.js,*.txt,*.hs,*.java,*.md,*.rb :call <SID>StripTrailingWhitespaces()


" Section: Functions 
" strips trailing whitespace at the end of files. this
" is called on buffer write in the autogroup above.
function! <SID>StripTrailingWhitespaces()
    " save last search & cursor position
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunction

function! <SID>CleanFile()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %!git stripspace
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

"""LATEX
" Word count:
" autocmd FileType tex map <leader><leader>o :w !detex \| wc -w<CR>
" Code snippets
" autocmd FileType tex inoremap ,fr \begin{frame}<Enter>\frametitle{}<Enter><Enter><++><Enter><Enter>\end{frame}<Enter><Enter><++><Esc>6kf}i
" autocmd FileType tex inoremap ,fi \begin{fitch}<Enter><Enter>\end{fitch}<Enter><Enter><++><Esc>3kA
" autocmd FileType tex inoremap ,exe \begin{exe}<Enter>\ex<Space><Enter>\end{exe}<Enter><Enter><++><Esc>3kA
" autocmd FileType tex inoremap ,em \emph{}<++><Esc>T{i
" autocmd FileType tex inoremap ,bf \textbf{}<++><Esc>T{i
" autocmd FileType tex vnoremap , <ESC>`<i\{<ESC>`>2la}<ESC>?\\{<Enter>a
" autocmd FileType tex inoremap ,it \textit{}<++><Esc>T{i
" autocmd FileType tex inoremap ,ct \textcite{}<++><Esc>T{i
" autocmd FileType tex inoremap ,cp \parencite{}<++><Esc>T{i
" autocmd FileType tex inoremap ,glos {\gll<Space><++><Space>\\<Enter><++><Space>\\<Enter>\trans{``<++>''}}<Esc>2k2bcw
" autocmd FileType tex inoremap ,x \begin{xlist}<Enter>\ex<Space><Enter>\end{xlist}<Esc>kA<Space>
" autocmd FileType tex inoremap ,ol \begin{enumerate}<Enter><Enter>\end{enumerate}<Enter><Enter><++><Esc>3kA\item<Space>
" autocmd FileType tex inoremap ,ul \begin{itemize}<Enter><Enter>\end{itemize}<Enter><Enter><++><Esc>3kA\item<Space>
" autocmd FileType tex inoremap ,li <Enter>\item<Space>
" autocmd FileType tex inoremap ,ref \ref{}<Space><++><Esc>T{i
" autocmd FileType tex inoremap ,tab \begin{tabular}<Enter><++><Enter>\end{tabular}<Enter><Enter><++><Esc>4kA{}<Esc>i
" autocmd FileType tex inoremap ,ot \begin{tableau}<Enter>\inp{<++>}<Tab>\const{<++>}<Tab><++><Enter><++><Enter>\end{tableau}<Enter><Enter><++><Esc>5kA{}<Esc>i
" autocmd FileType tex inoremap ,can \cand{}<Tab><++><Esc>T{i
" autocmd FileType tex inoremap ,con \const{}<Tab><++><Esc>T{i
" autocmd FileType tex inoremap ,v \vio{}<Tab><++><Esc>T{i
" autocmd FileType tex inoremap ,a \href{}{<++>}<Space><++><Esc>2T{i
" autocmd FileType tex inoremap ,sc \textsc{}<Space><++><Esc>T{i
" autocmd FileType tex inoremap ,chap \chapter{}<Enter><Enter><++><Esc>2kf}i
" autocmd FileType tex inoremap ,sec \section{}<Enter><Enter><++><Esc>2kf}i
" autocmd FileType tex inoremap ,ssec \subsection{}<Enter><Enter><++><Esc>2kf}i
" autocmd FileType tex inoremap ,sssec \subsubsection{}<Enter><Enter><++><Esc>2kf}i
" autocmd FileType tex inoremap ,st <Esc>F{i*<Esc>f}i
" autocmd FileType tex inoremap ,beg \begin{DELRN}<Enter><++><Enter>\end{DELRN}<Enter><Enter><++><Esc>4k0fR:MultipleCursorsFind<Space>DELRN<Enter>c
" autocmd FileType tex inoremap ,up <Esc>/usepackage<Enter>o\usepackage{}<Esc>i
" autocmd FileType tex nnoremap ,up /usepackage<Enter>o\usepackage{}<Esc>i
" autocmd FileType tex inoremap ,tt \texttt{}<Space><++><Esc>T{i
" autocmd FileType tex inoremap ,bt {\blindtext}
" autocmd FileType tex inoremap ,nu $\varnothing$
" autocmd FileType tex inoremap ,col \begin{columns}[T]<Enter>\begin{column}{.5\textwidth}<Enter><Enter>\end{column}<Enter>\begin{column}{.5\textwidth}<Enter><++><Enter>\end{column}<Enter>\end{columns}<Esc>5kA
" autocmd FileType tex inoremap ,rn (\ref{})<++><Esc>F}i

" Section: latex
" let g:airline#extensions#vimtex#enabled = 1

" show when lines extend past 80 characters 
highlight ColorColumn ctermfg=208 ctermbg=Black

function! MarkMargin (on)
    if exists('b:MarkMargin')
        try
            call matchdelete(b:MarkMargin)
        catch /./
        endtry
        unlet b:MarkMargin
    endif
    if a:on
        let b:MarkMargin = matchadd('ColorColumn', '\%89v\s*\zs\S', 100)
    endif
endfunction

augroup MarkMargin
    autocmd!
    autocmd  BufEnter  *       :call MarkMargin(1)
    autocmd  BufEnter  *.vp*   :call MarkMargin(0)
augroup END

augroup VisibleNaughtiness
    autocmd!
    autocmd BufEnter  *       set list
    autocmd BufEnter  *       set list
    autocmd BufEnter  *.txt   set nolist
    autocmd BufEnter  *.vp*   set nolist
    autocmd BufEnter  *       if !&modifiable
    autocmd BufEnter  *       set nolist
    autocmd BufEnter  *       endif
augroup END

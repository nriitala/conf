" .vimrc by Niko Riitala <nri@iki.fi>. Twitter: @nikoriitala
" No copyright, feel free to use this, as you like.
" 
" General VIM settings file. Optimized for OS X term and for PHP coding.
" Most of this file is copied from Tobias Schlitt's version of .vimrc

"cabbr checkjs !js /home/niko/bin/runjslint.js "`cat %`" \| lynx --force-html /dev/fd/5 -dump 5<&0 \| less

" {{{ File handling

au BufRead,BufNewFile *.phps		set filetype=php
au BufRead,BufNewFile *.phtml		set filetype=php
au BufRead,BufNewFile *.module		set filetype=php
au BufRead,BufNewFile *.inc 		set filetype=php
"au BufRead,BufNewFile *.css 		set filetype=php

au BufRead,BufNewFile *.txt         setlocal ft=txt 
au! BufRead,BufNewFile *.mkd        setfiletype mkd
au BufRead,BufNewFile *.todo        setfiletype todo 

" }}}

" {{{  Vim Settings  

" for manually compiled Vim 7.3
"let &runtimepath.=',/home/niko/vim/runtime'
"let $VIMRUNTIME = "/home/niko/vim/runtime"
set undofile                " Save undo's after file closes
set undodir=/home/niko/.vim/undo " where to save undo histories
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo

" old vim thingies continue
syntax on

" highlight current line in insert mode.
"autocmd InsertLeave * se nocul
"autocmd InsertEnter * se cul 

" switch paste mode off whenever insert mode is left
" autocmd InsertLeave <buffer> se nopaste

" source .vimrc after saving .vimrc
"autocmd bufwritepost .vimrc source $MYVIMRC

" colored column (to see line size violations)
"set colorcolumn=80

" use filetype plugins, e.g. for PHP
filetype plugin on

" show nice info in ruler
set ruler
set laststatus=2

" set standard setting for pear coding standards
set tabstop=2
set shiftwidth=2

" auto expand tabs to spaces
set expandtab

" auto indent after a {
set autoindent
set smartindent

" show line numbers by default
set number

" enable folding by fold markers
set foldmethod=marker 

" autoclose folds, when moving out of them
set foldclose=all

" use incremental searching
set incsearch

" do not highlight search results
" set nohlsearch

"set scrolljump=5
set scrolloff=5

" repair wired terminal/vim settings
set backspace=start,eol,indent

" toggle paste
set pastetoggle=§

set wrap 

" backup settings
set backup
set backupdir=/home/niko/.vim-backup
fun! InitBex()
    let aika = strftime("%y%m%d-%H%M")
    let myvar = "set backupext=_". aika
    execute myvar
    echo myvar
endfun
au BufWritePre * call InitBex()
set backupskip=/tmp/*,/private/tmp/*

" fix mistype :W and :Q
command! -bang -range=% -complete=file -nargs=* WQ <line1>,<line2>wq<bang> <args>
command! -bang -complete=file -nargs=* Qa qa<bang>
command! -bang -complete=file -nargs=* QA qa<bang>
command! -bang -range=% -complete=file -nargs=* Wq <line1>,<line2>wq<bang> <args>
command! -bang -range=% -complete=file -nargs=* W <line1>,<line2>w<bang> <args>
command! -bang Q quit<bang>

" Powerline
  " Remove delay between modes.
  set timeoutlen=1000 ttimeoutlen=0
  let g:powerline_config_path = $HOME.'/.config/powerline/config_files'

set noshowmode

" }}} 

" {{{  Misc settings, mappings, term settings

" some mappings
map t :tabnew 
nnoremap <C-f> :FufFile<CR>
nnoremap <C-d> :DiffChangesDiffToggle<CR>

" write with sudo ":w!!"
cnoremap w!! w !sudo tee % >/dev/null

"if &term =~ "xterm"
" if has("terminfo")
"   set t_Co=8
"   set t_Sf=<Esc>[3%p1%dm
"   set t_Sb=<Esc>[4%p1%dm
" else
"   set t_Co=8
"   set t_Sf=<Esc>[3%dm
"   set t_Sb=<Esc>[4%dm
" endif
"endif

function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

function! Tab_Or_Complete()
  if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    return "\<C-N>"
  else
    return "\<Tab>"
  endif
endfunction
:inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>

nnoremap <silent> <F8> :TlistToggle<CR>
nnoremap <silent> <F9> :NERDTree<CR>
nnoremap <silent> <C-D> :DiffSaved<CR>

" Unimpaired: Move line up/down
map <S-Up> [e
map <S-Down> ]e

map <C-l> :vertical wincmd f<CR>
map <C-p> :CtrlP<CR>
map <C-t> :tabnew<CR>
map <S-Left> :tabp<CR>
map <S-Right> :tabn<CR>
nmap <silent> <C-Up> :wincmd k<CR>
nmap <silent> <C-Down> :wincmd j<CR>
nmap <silent> <C-Right> :wincmd l<CR>
nmap <silent> <C-Left> :wincmd h<CR>
hi Comment ctermfg=blue

" fix arrow keys
set t_ku=OA
set t_kd=OB
set t_kr=OC
set t_kl=OD
set background=dark

" run zsh inside vim
let g:ConqueTerm_TERM = 'xterm'
command Z :ConqueTermVSplit zsh

" Change current work directory
command CD :cd %:p:h

" Count non-blank lines on current file
command Lines :!cat %|sed '/^\s*$/d'|wc -l

" Map leader key for nercommenter
let mapleader = "," 

" CtrlP settings
set wildignore+=*/tmp/*,*.so,*.swp,*.zip " MacOSX/Linux
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
" let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_dotfiles = 0
let g:ctrlp_switch_buffer = 0
let g:ctrlp_match_window_reversed = 0

" Double slash -> Case insensitive search
map // /\c
map ?? ?\c

" }}}

" {{{ Vundle

"set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" My Bundles here:
"
" original repos on github
Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'L9'
Bundle 'FuzzyFinder'
Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Bundle 'flazz/vim-colorschemes'
Bundle 'mattn/webapi-vim'
Bundle 'mattn/gist-vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'takac/vim-commandcaps'

filetype plugin indent on     " required!

" }}}

set rtp+=/home/niko/code/powerline/powerline/bindings/vim
let g:Powerline_symbols = 'fancy'

" Use 256 colours (Use this setting only if your terminal supports 256 colours)
set t_Co=256

set clipboard=unnamedplus
"colorscheme adrian
colorscheme tuutti

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
set undodir=/home/niko/vim/undo " where to save undo histories
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
set tabstop=4
set shiftwidth=4

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

" }}} 

" {{{  Misc settings, mappings, term settings

" some mappings
map t :tabnew 

" write with sudo ":w!!"
cnoremap w!! w !sudo tee % >/dev/null

if &term =~ "xterm"
 if has("terminfo")
   set t_Co=8
   set t_Sf=<Esc>[3%p1%dm
   set t_Sb=<Esc>[4%p1%dm
 else
   set t_Co=8
   set t_Sf=<Esc>[3%dm
   set t_Sb=<Esc>[4%dm
 endif
endif

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

map <C-t> :tabnew<CR>
map <C-Left> :tabp<CR>
map <C-Right> :tabn<CR>
hi Comment ctermfg=blue

" fix arrow keys
set t_ku=[A
set t_kd=[B
set t_kr=[C
set t_kl=[D

if (&term == "xterm")
  set t_ku=OA
  set t_kd=OB
  set t_kr=OC
  set t_kl=OD
"  set background=dark
endif

" run zsh inside vim
let g:ConqueTerm_TERM = 'xterm'
command Z :ConqueTermVSplit zsh

" }}}

" {{{ Vundle

set nocompatible               " be iMproved
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

filetype plugin indent on     " required!

" }}}

" .vimrc by Niko Riitala <nri@iki.fi>. Twitter: @nikoriitala
" No copyright, feel free to use this, as you like.
" 
" General VIM settings file. Optimized for OS X term and for PHP coding.
" Most of this file is copied from Tobias Schlitt's version of .vimrc

"cabbr checkjs !js /home/niko/bin/runjslint.js "`cat %`" \| lynx --force-html /dev/fd/5 -dump 5<&0 \| less

" {{{ File handling

au BufRead,BufNewFile *.phps		set filetype=php
au BufRead,BufNewFile *.phtml		set filetype=php
au BufRead,BufNewFile *.module	set filetype=php
au BufRead,BufNewFile *.inc 		set filetype=php
au BufRead,BufNewFile *.install	set filetype=php
au BufRead,BufNewFile *.test	  set filetype=php
au BufRead,BufNewFile *.profile	set filetype=php
au BufRead,BufNewFile *.theme	  set filetype=php
au BufRead,BufNewFile *.sass	  set filetype=sass
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

" reselect visual block after indent/outdent
"vnoremap < <gv
"vnoremap > >gv

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

" W for write
"cnoreabbrev <expr> W ((getcmdtype() is# ':' && getcmdline() is# 'W')?('w'):('W'))
"cnoreabbrev <expr> Wq ((getcmdtype() is# ':' && getcmdline() is# 'Wq')?('wq'):('Wq'))
"cnoreabbrev <expr> Q ((getcmdtype() is# ':' && getcmdline() is# 'Q')?('q'):('Q'))

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
nnoremap <C-s> :SyntasticCheck<CR>

" drush mappings
nnoremap <leader>dcca :!drush cc all<CR>
nnoremap <leader>dcm :!drush cc menu<CR>
nnoremap <leader>dct :!drush cc theme<CR>
nnoremap <leader>dcc :!drush cc css+js<CR>
nnoremap <leader>dul :!drush uli<CR>

" git mappings
nnoremap <Leader>gd :Gdiff<Enter>
nnoremap <Leader>gD :GitDiff --cached<Enter>
nnoremap <Leader>gs :Gstatus<Enter>
nnoremap <Leader>gl :GitLog<Enter>
nnoremap <Leader>ga :GitAdd<Enter>
nnoremap <Leader>gA :GitAdd <cfile><Enter>
nnoremap <Leader>gc :GitCommit<Enter>
nnoremap <Leader>gp :GitPullRebase<Enter>

" write with sudo ":w!!"
cnoremap w!! w !sudo tee % >/dev/null

nnoremap <silent> <F8> :TlistToggle<CR>
nnoremap <silent> <F9> :NERDTree<CR>
nnoremap <silent> <C-D> :DiffSaved<CR>

" Reselect visual block after indent/outdent
"vnoremap < <gv
"vnoremap > >gv

" Move lines up and down 
"nnoremap <S-j> :m .+1<CR>==
"nnoremap <S-k> :m .-2<CR>==
"noremap <S-k> :m .-2<CR>==gi<ESC>
"noremap <S-j> :m .+1<CR>==gi<ESC>
" " " "vnoremap <S-j> :m '>+1<CR>gv=gv
" " " "vnoremap <S-k> :m '<-2<CR>gv=gv

nnoremap <S-Down> :m .+1<CR>==
nnoremap <S-Up> :m .-2<CR>==
inoremap <S-Down> <Esc>:m .+1<CR>==gi
inoremap <S-Up> <Esc>:m .-2<CR>==gi
vnoremap <S-Down> :m '>+1<CR>gv=gv
vnoremap <S-Up> :m '<-2<CR>gv=gv

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

" Some Drupal coding standard stuff
let g:syntastic_phpcs_conf=" --standard=$HOME/.drush/coder/coder_sniffer/Drupal --extensions=php,module,inc,install,test,profile,theme"
let g:syntastic_php_checkers = ['php', 'phpcs']
let g:syntastic_php_phpcs_args=" --standard=$HOME/.drush/coder/coder_sniffer/Drupal --extensions=php,module,inc,install,test,profile,theme" 
let g:syntastic_sass_checkers = ['sass']

" Other Syntastic settings
let g:syntastic_error_symbol = "✗"
let g:syntastic_warning_symbol = "⚠"

" Double slash -> Case insensitive search
map // /\c
map ?? ?\c

" Map ctrl-e for Extradite plugin
map <C-e> :Extradite!<CR>

" }}} 

" {{{ Functions

function! TrimWhiteSpace()
  %s/\s\+$//e
endfunction

autocmd FileWritePre    * :call TrimWhiteSpace()
autocmd FileAppendPre   * :call TrimWhiteSpace()
autocmd FilterWritePre  * :call TrimWhiteSpace()
autocmd BufWritePre     * :call TrimWhiteSpace()

function RemoveHtml()
  %s#<[^>]\+>##g
endfunction

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

" }}}  

" {{{ Vundle

"set nocompatible               " be iMproved
filetype off                   " required!

"set rtp+=~/.vim/bundle/vundle/
set rtp+=~/.vim/bundle/Vundle.vim
"call vundle#rc()
call vundle#begin()

"Bundle 'gmarik/vundle'
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" My Bundles here:
"
" original repos on github
Plugin 'tpope/vim-fugitive'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'L9'
Plugin 'FuzzyFinder'
"Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'flazz/vim-colorschemes'
Plugin 'mattn/webapi-vim'
Plugin 'mattn/gist-vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'takac/vim-commandcaps'
Plugin 'scrooloose/syntastic'
Plugin 'mattn/emmet-vim'
Plugin 'pangloss/vim-javascript'
Plugin 'stephpy/vim-php-cs-fixer'
Plugin 'int3/vim-extradite'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required!

" }}}

set rtp+=/home/niko/code/powerline/powerline/bindings/vim
let g:Powerline_symbols = 'fancy'

" Use 256 colours (Use this setting only if your terminal supports 256 colours)
set t_Co=256

set clipboard=unnamedplus
"colorscheme adrian
colorscheme tuutti

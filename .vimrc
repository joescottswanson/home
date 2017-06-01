set nocompatible

" this sets up vundle to manage plugins
" https://github.com/gmarik/vundle
" to use:
"   mkdir -p ~/.vim/bundle
"   git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
"   vim +BundleInstall

" <vundle-config>

  filetype off

  set rtp+=~/.vim/bundle/vundle/
  call vundle#rc()

  " let Vundle manage Vundle - required
  Bundle 'gmarik/vundle'

  " really nice file tree:
  Bundle 'scrooloose/nerdtree'

  " align text vertically on a string:
  Bundle 'Align'

  " wrap common version control commands:
  Bundle 'vcscommand.vim'
  Bundle 'tpope/vim-fugitive'

  " a bunch of colorschemes + a gui menu listing them
  Bundle 'flazz/vim-colorschemes'
  Bundle 'altercation/vim-colors-solarized'
  Bundle 'chriskempson/vim-tomorrow-theme.git'
  Bundle 'desert-warm-256'
  Bundle 'ColorSchemeMenuMaker'

  " match lots of things
  Bundle 'geoffharcourt/vim-matchit'

  Bundle 'L9'
  Bundle 'FuzzyFinder'
  " Bundle 'surround.vim'

" </vundle-config>

set title

syntax on
filetype plugin on
filetype indent on

" adds line numbers
 set number

" do not beep or flash at me
" vb is needed to stop beep
" t_vb sets visual bell action, we're nulling it out here)
" note also that this may need to be repeated in .gvimrc
set visualbell
set t_vb=

" enable mouse for (a)ll, (n)ormal, (v)isual, (i)nsert, or (c)ommand line
" mode - seems to work in most terminals
set mouse=a

" let me delete stuff like crazy in insert mode
set backspace=indent,eol,start

" display commands as-typed + current position in file
set showcmd
set ruler

" add git status to statusline; otherwise emulate standard line with ruler
set statusline=%<%{fugitive#statusline()}\ %f\ %h%m%r%=%-14.(%l,%c%V%)\ %P

" keep lots of command-line history
set history=3500

" search:
set incsearch
set ignorecase
set smartcase

" display tab characters as 8 spaces, indent 2 spaces,
" always use spaces instead of tabs
set tabstop=8
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent
"set smarttab
"set smartindent

" for gvim. no toolbar, otherwise these are the defaults:
set guioptions=aegimrLt

" Use + register (X Window clipboard) as unnamed register
" set clipboard=unnamedplus,autoselect

" turn off tab expansion for Makefiles
" au BufEnter ?akefile* set noexpandtab
" au BufLeave ?akefile* set expandtab
au FileType make setlocal noexpandtab

" -- TWEAKME --

" use comma for the leader key
let mapleader = ","

" treat p1k3 entries as HTML. lazy, but unlikely to hit many false positives:
au BufReadPost,BufNewFile */p1k3/*[0123456789]* call PikeHighlight()

" the ! means this can be freely redeclared - makes it easier to source
" ~/.vimrc after changes
fun! PikeHighlight()
  " make sure NERDTree windows don't get messed up
  if bufname("%") =~ "NERD_tree"
    return
  endif

  " the initial slash seems to be necessary to make \v work
  if bufname("%") =~ "\\v([0-9]{1,2}|[a-z]+)$"
    set filetype=html
  endif
endfun

" assume *.t files are PHP - not actually much use for this
au BufRead,BufNewFile *.t set filetype=php

" <keybindings>

  " split lines under the cursor
  map K i<CR><Esc>g;

  " get a datestamp for a p1k3 entry
  " .-1 puts it on the current line, since :r reads onto the line below the
  " current one (or below the specified line - so here we're specifying the
  " one before the current one)
  nmap <leader>td :.-1r !today<CR><CR>

  " reformat a paragraph
  nmap <leader>q gqip

  " write all changed buffers
  nmap <leader>w :wa<CR>

  " pull up the last hundred git commits in a new window
  " TODO: put this in a function
  nmap <leader>l :vnew<CR>:r !git log -100<CR>:set ft=git<CR>gg<C-w>r<C-w>l

  map <F2> :NERDTreeToggle<CR>
  map <F3> :NERDTreeFind<CR>
  map <F4> :set invnumber<CR>
  imap <F4> <ESC>:set invnumber<CR>a
  " toggle search highlighting:
  map <F9> :set invhlsearch<CR>

  " tab navigation somewhat like firefox
  " http://vim.wikia.com/wiki/Alternative_tab_navigation
  nmap <C-S-Tab> :tabprevious<CR>
  nmap <C-Tab> :tabnext<CR>
  map <C-S-Tab> :tabprevious<CR>
  map <C-Tab> :tabnext<CR>
  imap <C-S-Tab> <Esc>:tabprevious<CR>i
  imap <C-Tab> <Esc>:tabnext<CR>i       
  " new tab:
  nmap <leader>tn :tabnew<CR>

  " fuzzyfinder
  nmap <leader>f :FufFile<CR>

  " check PHP syntax - TODO: expand to syntax check [whatever filetype]
  noremap <leader>c :!php -l %<CR>

  " display tabs - ,s will toggle (redraws just in case)
  nmap <silent> <leader>s :set nolist!<CR>:redr<CR>
  set listchars=tab:⇾\ ,trail:·
  set list

" </keybindings>

" retain view/folds
au BufWinLeave notes mkview
au BufWinEnter notes silent loadview

" read (unchanged) buffers when they're modified on filesystem
set autoread

" <colors>
" colorscheme brookstream
colorscheme pyte
" colorscheme mustang
" </colors>

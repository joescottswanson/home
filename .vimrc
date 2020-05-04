" this sets up vundle to manage plugins
" https://github.com/gmarik/vundle
" to use:
"   mkdir -p ~/.vim/bundle
"   git clone http://github.com/VundleVim/vundle.vim.git ~/.vim/bundle/Vundle.vim
"   vim +BundleInstall

" <vundle-config>

  set nocompatible
  filetype off

  set rtp+=~/.vim/bundle/Vundle.vim
  call vundle#begin()

  " let Vundle manage Vundle - required
  Plugin 'VundleVim/Vundle.vim'

  " really nice file tree:
  Plugin 'scrooloose/nerdtree'

  " align text vertically on a string:
  Plugin 'Align'

  " wrap common version control commands:
  Plugin 'vcscommand.vim'
  Plugin 'tpope/vim-fugitive'

  " a bunch of colorschemes + a gui menu listing them
  Plugin 'flazz/vim-colorschemes'
  Plugin 'altercation/vim-colors-solarized'
  Plugin 'chriskempson/vim-tomorrow-theme.git'
  Plugin 'desert-warm-256'
  Plugin 'ColorSchemeMenuMaker'

  " match lots of things
  Plugin 'geoffharcourt/vim-matchit'

  Plugin 'L9'
  Plugin 'FuzzyFinder'
  " Plugin 'surround.vim'

  Plugin 'vimwiki/vimwiki'
  Plugin 'vim-vdebug/vdebug'

  Plugin 'w0rp/ale'

  call vundle#end()
  filetype plugin indent on
" </vundle-config>

set title
syntax on

" set 2 character indentation for php files
autocmd BufRead,BufNewFile *.php setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab smarttab

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
set shiftwidth=2
set softtabstop=2
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

" assume *.t files are PHP - not actually much use for this
" au BufRead,BufNewFile *.t set filetype=php

" <keybindings>

  " split lines under the cursor
  map K i<CR><Esc>g;

  " get a datestamp
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
  " nmap <C-S-Tab> :tabprevious<CR>
  " nmap <C-Tab> :tabnext<CR>
  " map <C-S-Tab> :tabprevious<CR>
  " map <C-Tab> :tabnext<CR>
  " imap <C-S-Tab> <Esc>:tabprevious<CR>i
  " imap <C-Tab> <Esc>:tabnext<CR>i       
  " new tab:
  nmap <leader>tn :tabnew<CR>

  " fuzzyfinder
  nmap <leader>f :FufFile<CR>

  " display tabs - ,s will toggle (redraws just in case)
  nmap <silent> <leader>s :set nolist!<CR>:redr<CR>
  set listchars=tab:⇾\ ,trail:·
  set list

  let g:vdebug_keymap = {
  \ "run" : "<Leader>/",
  \ "run_to_cursor" : "<Down>",
  \ "step_over" : "<Up>",
  \ "step_into" : "<Left>",
  \ "step_out" : "<Right>",
  \ "close" : "q",
  \ "detach" : "<F7>",
  \ "set_breakpoint" : "<Leader>s",
  \ "eval_visual" : "<leader>e"
  \}
" </keybindings>

" read (unchanged) buffers when they're modified on filesystem
set autoread

" <colors>
" colorscheme brookstream
" colorscheme pyte
" colorscheme mustang
" </colors>

let g:vdebug_options = {'ide_key': 'netbeans-xdebug'}
let g:vdebug_options = {'server': 'localhost'}
let g:vdebug_options = {'port': '9000'}
let g:vdebug_options['watch_window_style'] = 'compact'

" folding configs
" set foldmethod=indent
" set foldlevel=1

" linter setup
let g:ale_echo_msg_format = '%linter% says %s'
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_linters = {'javascript': ['eslint']}

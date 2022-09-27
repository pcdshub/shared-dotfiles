" .vimrc ($HOME/.vimrc)
" vi: sw=2 ts=2 sts=2
"
set secure                             " secure modeline processing
set nocompatible                       " use modern vim, not vi stuff

" mapleader is the key to be used for plugins and other mappings that have
" <Leader> used in them.  You're free to change it, but I've found that space
" works rather well:
let mapleader="\<Space>"               " prefix when using <leader> in map

" If you'd like your working directory to change depending on the file you
" open, use 'set acd':
" set acd                              " current directory follows file being edited

" Otherwise, use the default we provide here:
set noacd                              " current directory does not follow file being edited
set autoindent                         " always set autoindenting on
set backspace=2 whichwrap+=<,>,[,]     " backspace and cursor keys wrap to previous/next line
set expandtab                          " tabs -> spaces (use :retab to force a conversion)
set foldlevel=99
set foldmethod=indent
" set guifont=Consolas:h10
set guioptions=cmgtTr
set history=500                        " keep x lins of command line history
set hlsearch                           " highlight things you've searched for
set ignorecase smartcase               " case-insensitive (ic) search by default (-> noic is the opposite)
                                       " except: if you search for AStringLikeThis, it will be case sensitive
set imdisable                          " Disable the IME (gvim and unicode don't play well on different locale)
set incsearch                          " do incremental searching
" set mouse+=a                           " enable mouse mode (terminal dependent) commented: messes with copy in mobaXterm
set nobackup                           " disable writing .bak
set novb                               " ** visual bell, no beeping! **
set number                             " line numbering
set numberwidth=5                      " the width of the number column in characters
set ruler                              " show the cursor position all the time
set showcmd                            " display incomplete commands
set smartindent                        " smartindent when starting new line
set tabstop=4 shiftwidth=4 autoindent  " 4 spaces per tab
set undofile                           " use undo files to undo your work
set undolevels=10000                   " keep this many undo steps available
set undoreload=20000
set wrap                               " wrap text at the end of your screen (-> nowrap)

" Don't show files that match these for tab completion
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
set wildignore+=*\\tmp\\*,*.exe

if has('termguicolors')
  " Depending on your terminal, you might get 24-bit color support
  set termguicolors
endif

if !has('nvim') && &term =~ '^screen'
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
endif

if has("gui") || has("gui_running")
  " GUI-specific (gvim) settings
  " Alt-Space is System menu
  noremap <M-Space> :simalt ~<CR>
  inoremap <M-Space> <C-O>:simalt ~<CR>
  cnoremap <M-Space> <C-C>:simalt ~<CR>
endif

if &diff
  " In vimdiff mode, these options will be used
  " * 'filler' lines keep the diff on each side aligned
  " * 'context:3' - 3 lines of context between change/unchanged lines
  set diffopt=filler,context:3
endif

" Enable filetype detection, plugins, and indentation
"   Scripts used by this may be customized or they fall back to those
"   defined at the system level: /usr/share/vim/
"   Example paths below are from psbuild-rhel7.
"   The actual full search path can be found with a ``:set runtimepath``.
"
"  - filetype: detect the type of file you are editing
"  - plugin: enable plugins based on file type
"       See for example: /usr/share/vim/vim74/ftplugin/python.vim
"  - indent: load indent settings on a per-filetype basis
"       See for example: /usr/share/vim/vim74/indent/python.vim
filetype plugin indent on
" Enable syntax highlighting
syntax on

" Don't use Ex mode, use Q for formatting
" If you don't know what it is, Ex mode is likely just going to confuse you.
" I would recommend keeping this setting mapping Q to something else.
map Q gq

" Python settings.  With filetype detection on, these settings will be used
" for all .py files.
au FileType python
    \ set tabstop=4
    \     softtabstop=4
    \     shiftwidth=4
    \     textwidth=79
    \     expandtab
    \     autoindent
    \     fileformat=unix
    \     encoding=utf-8

" General settings for shell/vim scripts, c++, etc.
au FileType sh,vim,cpp,yaml
    \ set tabstop=2
    \     softtabstop=2
    \     shiftwidth=2
    \     expandtab
    \     autoindent

" Show bad whitespace in an obvious but not obnoxious color
highlight pythonSpaceError ctermbg=darkgreen guibg=darkgreen
highlight BadWhitespace ctermbg=darkgreen guibg=darkgreen

au BufNewFile,BufRead *.py,*.pyw,*.c,*.h,*.cc,*.hh,*.sh match BadWhitespace /\s\+$/

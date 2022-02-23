" .vimrc ($HOME/.vimrc)
" vi: sw=2 ts=2 sts=2
"
" secure modeline processing
set secure

" allow backspacing over everything in insert mode
let mapleader="\<Space>"               " prefix when using <leader> in map

" set acd                                " current directory follows file being edited
set noacd                              " current directory follows file being edited
set autoindent                         " always set autoindenting on
set backspace=2 whichwrap+=<,>,[,]     " backspace and cursor keys wrap to previous/next line
set expandtab                          " tabs -> spaces (:retab)
set foldlevel=99
set foldmethod=indent
" set guifont=Consolas:h10
set guioptions=cmgtTr
set history=500                        " keep x lins of command line history
set hlsearch
set ic                                 " case-insensitive search by default
set ignorecase smartcase
set imdisable                          " Disable the IME (gvim and unicode don't play well on different locale)
set incsearch                          " do incremental searching
set mouse+=a
set nobackup
set novb                               " ** visual bell, no beeping! **
set nowritebackup
set number                             " line numbering
set numberwidth=5
set ruler                              " show the cursor position all the time
set showcmd                            " display incomplete commands
set smartindent                        " smartindent when starting new line
set tabstop=4 shiftwidth=4 autoindent
set undofile
set undolevels=10000
set undoreload=20000
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
set wildignore+=*\\tmp\\*,*.exe
set wrap

if has('termguicolors')
  set termguicolors
endif

if !has('nvim') && &term =~ '^screen'
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
endif

if has("gui") || has("gui_running")
  " Alt-Space is System menu
  noremap <M-Space> :simalt ~<CR>
  inoremap <M-Space> <C-O>:simalt ~<CR>
  cnoremap <M-Space> <C-C>:simalt ~<CR>
endif

if &diff
  set diffopt=filler,context:3
endif

filetype plugin indent on
syntax on

" Don't use Ex mode, use Q for formatting
" If you don't know what it is, Ex mode is likely just going to confuse you.
" I would recommend keeping this setting mapping Q to something else.
map Q gq

    set nocompatible
    let mapleader=","
    " pathogen stuff
    " execute pathogen#infect()
    " call pathogen#helptags()
    " call pathogen#incubate()
    filetype off                  " required!

    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()

    set encoding=utf-8

    " let Vundle manage Vundle
    " required! 
    Bundle 'gmarik/vundle'

    " Bundles
    Bundle 'vim-scripts/Align'
    Bundle 'Raimondi/delimitMate'
    Bundle 'tpope/vim-ragtag'
    Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
    Bundle 'Lokaltog/powerline-fonts'
    Bundle 'airblade/vim-rooter'
    Bundle 'tpope/vim-surround'
    Bundle 'scrooloose/syntastic'
    Bundle 'tpope/vim-commentary'
    Bundle 'SirVer/ultisnips'
    Bundle 'kien/ctrlp.vim'
    Bundle 'Valloric/YouCompleteMe'
    Bundle 'tpope/vim-sensible.git'
    Bundle 'majutsushi/tagbar'
    Bundle 'tpope/vim-fugitive'

    " Syntax plugins
    Bundle 'petRUShka/vim-opencl'
    Bundle 'beyondmarc/glsl.vim'
    Bundle 'hail2u/vim-css3-syntax'
    Bundle 'othree/html5-syntax.vim'
    Bundle 'tpope/vim-markdown'
    Bundle 'jelera/vim-javascript-syntax'
    Bundle 'tpope/vim-haml'
    Bundle 'jQuery'
    Bundle 'derekwyatt/vim-scala'


    "Colours
    Bundle 'jnurmine/Zenburn'

    " Enable syntax highlighting
    syntax on
    "And indenting
    filetype plugin indent on
    " Tell vim to hide buffers
    set hidden

    set ambiwidth=single
    set nowrap        " don't wrap lines
    set expandtab
    set tabstop=2     " a tab is two spaces
    set backspace=indent,eol,start
                      " allow backspacing over everything in insert mode
    set autoindent    " always set autoindenting on
    set copyindent    " copy the previous indentation on autoindenting
    set number        " always show line numbers
    set relativenumber " relative numbers too
    set shiftwidth=2  " number of spaces to use for autoindenting
    set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
    set showmatch     " set show matching parenthesis
    set ignorecase    " ignore case when searching
    set smartcase     " ignore case if search pattern is all lowercase,
                      "    case-sensitive otherwise
    set smarttab      " insert tabs on the start of a line according to
                      "    shiftwidth, not tabstop
    set hlsearch      " highlight search terms
    set incsearch     " show search matches as you type

    set noundofile
    set history=1000         " remember more commands and search history
    set undolevels=1000      " use many muchos levels of undo
    set wildignore=*.swp,*.bak,*.pyc,*.class
    set title                " change the terminal's title
    set visualbell           " don't beep
    set noerrorbells         " don't beep

    " Just the 81st column of wide lines...
    highlight WhiteOnRed ctermfg=white ctermbg=red
    call matchadd('WhiteOnRed', '\%79v', 100)

    set formatoptions+=w
    set tw=80

    " Maybe remove these
    set nobackup
    set noswapfile

    set mouse=a

    " Get rid of the arrow keys!
    map <up> <nop>
    map <down> <nop>
    map <left> <nop>
    map <right> <nop>

    " This will be useful for long lines in Latex files
    nnoremap j gj
    nnoremap k gk
    nnoremap Q <nop>

    " Easy window navigation
    map <C-h> <C-w>h
    map <C-j> <C-w>j
    map <C-k> <C-w>k
    map <C-l> <C-w>l

    " Clear search with ./
    nmap <silent> ,/ :nohlsearch<CR>

    " This is a doosy
    cmap w!! w !sudo tee % >/dev/null

    " For pasting in lots of stuff from tinternet
    set pastetoggle=<F2>

    imap jk <esc>

    " This doesn't work very nicely vmap jk <esc>

    set t_Co=256
    colorscheme zenburn
    let g:Powerline_symbols = 'fancy'

"=====[ YouCompleteMe Options ]===============================================

    let g:ycm_collect_identifiers_from_tags_files = 1
    let g:ycm_extra_conf_globlist = ['~/code/*','!~/*']

"=====[ UltiSnips Options ]===============================================
    let g:UltiSnipsExpandTrigger = '<c-l>'
    let g:UltiSnipsJumpForwardTrigger = '<c-j>'
    let g:UltiSnipsJumpBackwardTrigger = '<c-k>'
    "let g:UltiSnipsListSnippets = '<c-m>'

"=====[ CtrlP Options ]===============================================
    let g:ctrlp_custom_ignore = {
      \ 'dir':   '\v(\.(git|hg|svn)$|build$)',
      \ 'file':  '\v\.(so|swp|zip)$',
      \ }
    nnoremap <silent> <Leader>t :CtrlP<cr>
    nnoremap <silent> <leader>T :ClearCtrlPCache<cr>\|:CtrlP<cr>
    nnoremap <leader>. :CtrlPTag<cr>

"=====[ Tagbar ]====================================
    nnoremap <silent> <Leader>b :TagbarToggle<CR>

"=====[ Remove all the rubbish from gvim]====================================

    set guioptions-=m  "remove menu bar
    set guioptions-=T  "remove toolbar
    set guioptions-=r  "remove right-hand scroll bar
    set guifont=Terminess\ Powerline "Set the GVIM font to terminus

"=====[ Highlight matches when jumping to next ]=============

    " This rewires n and N to do the highlighing...
    nnoremap <silent> n   n:call HLNext(0.4)<cr>
    nnoremap <silent> N   N:call HLNext(0.4)<cr>

    " Just highlight the match in red...
    function! HLNext (blinktime)
        let [bufnum, lnum, col, off] = getpos('.')
        let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
        let target_pat = '\c\%#'.@/
        let ring = matchadd('WhiteOnRed', target_pat, 101)
        redraw
        exec 'sleep ' . float2nr(a:blinktime * 500) . 'm'
        call matchdelete(ring)
        redraw
    endfunction

"====[ Drag visuals plugin ]=================================================

    runtime plugin/dragvisuals.vim
    vmap  <expr>  <LEFT>   DVB_Drag('left')
    vmap  <expr>  <RIGHT>  DVB_Drag('right')
    vmap  <expr>  <DOWN>   DVB_Drag('down')
    vmap  <expr>  <UP>     DVB_Drag('up')
    vmap  <expr>  D        DVB_Duplicate()

    " Remove any introduced trailing whitespace after moving...     ##
    let g:DVB_TrimWS = 1


"====[ Make tabs, trailing whitespace, and non-breaking spaces visible ]======

    exec "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:~"
    set list

"====[ Swap : and ; to make colon commands easier to type ]======

    nnoremap  ;  :
    "nnoremap  :  ;

"====[ Swap v and CTRL-V, because Block mode is more useful that Visual mode "]======

    nnoremap    v   <C-V>
    nnoremap <C-V>     v

    vnoremap    v   <C-V>
    vnoremap <C-V>     v

"====[ Always turn on syntax highlighting for diffs ]=========================

    filetype on
    augroup PatchDiffHighlight
        autocmd!
        autocmd FileType  diff   syntax enable
    augroup END


"====[ Open any file with a pre-existing swapfile in readonly mode "]=========

    augroup NoSimultaneousEdits
        autocmd!
        autocmd SwapExists * let v:swapchoice = 'o'
        autocmd SwapExists * echomsg ErrorMsg
        autocmd SwapExists * echo 'Duplicate edit session (readonly)'
        autocmd SwapExists * echohl None
        autocmd SwapExists * sleep 2
    augroup END

"====[ Mappings to activate spell-checking alternatives ]================

    nmap  ;s     :set invspell spelllang=en<CR>

    " To create the en-basic (or any other new) spelling list:
    "
    "     :mkspell  ~/.vim/spell/en-basic  basic_english_words.txt
    "
    " See :help mkspell


"====[ Make CTRL-K list diagraphs before each digraph entry ]===============

    inoremap <expr>  <c-n>   BDG_GetDigraph() 

au BufNewFile,BufRead *.glslf,*.glslv,*.frag,*.vert,*.glsl SetGLSLFileType

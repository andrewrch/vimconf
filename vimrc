set nocompatible
let mapleader=","

set encoding=utf-8
set ambiwidth=single
set fileencoding=utf-8
set fileformats=unix

" We need modelines.
set modeline
set shellslash

set sessionoptions=buffers,tabpages,winsize,curdir
set ruler
if has('conceal') | set conceallevel=2 concealcursor=ncv | endif
"
"" Tell vim to hide buffers
set hidden
"
set ambiwidth=single
set tabstop=2      " a tab is two spaces
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set number         " always show line numbers
set relativenumber " relative numbers too
set shiftwidth=2  " number of spaces to use for autoindenting
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set showmatch     " set show matching parenthesis
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase, case-sensitive otherwise
set expandtab
set smarttab      " insert tabs on the start of a line according to
"                 "    shiftwidth, not tabstop
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type
"
" Turn off undo file
set nobackup
set noswapfile
set noundofile

set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set visualbell           " don't beep
set noerrorbells         " don't beep
set formatoptions+=w
set textwidth=79
set nowrap        " don't wrap lines
set title
set titlelen=60
"" Update by redraw and not INS/DEL
set showcmd
set showfulltag
set showmatch
" Show me the overflow.
if has('syntax') && v:version >= 704
  call matchadd('ColorColumn', '\%' . &textwidth . 'v', 80)
endif
"
set t_Co=256
set mouse=a
set cindent
"" For pasting in lots of stuff from tinternet
set pastetoggle=<F2>

set wildmenu wildmode=longest:full
set wildoptions=tagfile
if has('wildignore') && v:version >= 704 | set wildignorecase | endif
"" Ignore a lot of stuff.
set wildignore+=*.swp,*.pyc,*.bak,*.class,*.orig
set wildignore+=.git,.hg,.bzr,.svn
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg,*.svg
set wildignore+=build/*,tmp/*,vendor/cache/*,bin/*,debug/*,release/*
set wildignore+=.ycm_extra_conf.*

"=====[ Highlight matches when jumping to next ]=============
" This rewires n and N to do the highlighing...
nnoremap <silent> n   n:call HLNext(0.4)<cr>
nnoremap <silent> N   N:call HLNext(0.4)<cr>

" Just highlight the match in red...
highlight WhiteOnRed ctermfg=white ctermbg=red
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
"====[ Make tabs, trailing whitespace, and non-breaking spaces visible ]======

exec "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:~"
set list

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

"====[ Vundle! ]==============================================================
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Required
Plugin 'xolox/vim-misc'

" utils
Plugin 'gmarik/vundle'
Plugin 'Shougo/neomru.vim'
Plugin 'Shougo/unite.vim'
Plugin 'Shougo/vimproc.vim'
"Plugin 'vim-scripts/Align'
Plugin 'Raimondi/delimitMate'
"Plugin 'jalcine/cmake.vim'
Plugin 'tpope/vim-ragtag'
Plugin 'mbbill/undotree'
Plugin 'airblade/vim-rooter'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-repeat'
Plugin 'mhinz/vim-signify'
Plugin 'ervandew/supertab'
Plugin 'tpope/vim-sensible.git'
"Plugin 'godlygeek/tabular'
Plugin 'tmux-plugins/vim-tmux'
Plugin 'wellle/tmux-complete.vim'
Plugin 'xolox/vim-session'
Plugin 'Chiel92/vim-autoformat'
Plugin 'mhinz/vim-startify'

" unite add ons
Plugin 'tsukkee/unite-tag'
Plugin 'yuku-t/unite-git'
Plugin 'h1mesuke/unite-outline'

" editor add ons
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'majutsushi/tagbar'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'roman/golden-ratio'
Plugin 'Lokaltog/powerline-fonts'

Plugin 'honza/vim-snippets'
Plugin 'Shougo/neocomplete.vim'

" version control
Plugin 'tpope/vim-fugitive'

" languages
Plugin 'sheerun/vim-polyglot'
Plugin 'lambdatoast/elm.vim'
Plugin 'petRUShka/vim-opencl'
Plugin 'beyondmarc/glsl.vim'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'othree/html5-syntax.vim'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'tpope/vim-haml'
Plugin 'jQuery'
Plugin 'derekwyatt/vim-scala'
Plugin 'dbakker/vim-lint'

"Colours
Plugin 'jnurmine/Zenburn'

colorscheme zenburn
" Enable syntax highlighting
syntax on
"And indenting
filetype plugin indent on

"=====[ Unite Options ]===============================================
let g:unite_source_history_yank_enable = 1
let g:unite_data_directory='~/.vim/unite'
"let g:unite_enable_start_insert = 1
let g:unite_prompt='» '
let g:unite_source_rec_max_cache_files=5000
let g:unite_split_rule = "botright"
let g:unite_winheight = 10
let g:unite_force_overwrite_statusline = 0
let g:unite_candidate_icon = '-'
let g:unite_cursor_line_highlight = 'WhiteOnRed'
let g:unite_marked_icon = '+'

let s:unite_ignores = [
      \ '\.git', 'deploy', 'dist', '\.ycm_extra_conf.py',
      \ '\.ycm_extra_conf.pyc',
      \ 'undo', 'tmp', 'backups',
      \ 'generated', '/build/', 'release', 'debug', 'images']
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#custom#source('file_rec,file_rec/async,file_mru,file,buffer,grep,tag',
      \ 'ignore_pattern', unite#get_all_sources('file_rec')['ignore_pattern'] .
      \ join(s:unite_ignores, '\|'))

func! s:call_unite(sources)
  ""exec(':Unite -direction=botright -unique -truncate -sync ' . a:sources)
  exec(':Unite -toggle -auto-resize -buffer-name='. a:sources)
endfunc

nnoremap <leader>fv :<C-u>Unite -default-action=vsplit -buffer-name=files -truncate -start-insert file_rec/async:!<cr>
nnoremap <leader>fs :<C-u>Unite -default-action=split -buffer-name=files -truncate -start-insert file_rec/async:!<cr>
nnoremap <leader>f. :<C-u>Unite -buffer-name=files -truncate -start-insert file_rec/async:!<cr>
nnoremap <leader>F :<C-u>Unite -buffer-name=files -start-insert file<cr>
nnoremap <leader>r :<C-u>Unite -buffer-name=mru -start-insert file_mru<cr>
nnoremap <leader>y :<C-u>Unite -buffer-name=yank history/yank<cr>
nnoremap <leader>ev :<C-u>Unite -default-action=vsplit -buffer-name=buffer buffer<cr>
nnoremap <leader>es :<C-u>Unite -default-action=split -buffer-name=buffer buffer<cr>
nnoremap <leader>e. :<C-u>Unite -buffer-name=buffer buffer<cr>
nnoremap <leader>tv :<C-u>Unite -default-action=vsplit -buffer-name=tags -truncate -start-insert tag<cr>
nnoremap <leader>ts :<C-u>Unite -default-action=split -buffer-name=tags -truncate -start-insert tag<cr>
nnoremap <leader>t. :<C-u>Unite -buffer-name=tags -truncate -start-insert tag<cr>

"=====[ c/c++ Options ]===============================================
let g:load_doxygen_syntax=1
"    let g:doxygen_enhanced_color=1
let g:c_comment_strings=1
let g:c_curly_errors=1
let g:c_gnu=0
let g:c_no_c99=1
let g:c_space_errors=1

"=====[ cmake Options ]===============================================
let g:cmake_build_dirs = [ "build" ]
let g:cmake_build_type = "Debug"

"=====[ Startify Options ]===============================================


"=====[ Airline Options ]===============================================
let g:airline_theme='zenburn'
let g:airline_detected_modified=1
let g:airline_powerline_fonts=1
let g:airline_detect_iminsert=1
let g:airline#extensions#hunks#non_zero_only=1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#branch#enabled=1
let g:airline#extensions#whitespace#enabled=1
let g:airline#extensions#whitespace#mixed_indent_algo=1
let g:airline#extensions#whitespace#show_message=1
let g:airline#extensions#whitespace#trailing_format='s [%s]'
let g:airline#extensions#whitespace#mixed_indent_format='i [%s]'
let g:airline_mode_map={
      \ '__' : '-',
      \ 'n' : 'N',
      \ 'i' : 'I',
      \ 'R' : 'R',
      \ 'v' : 'V',
      \ 'V' : 'B'
      \ }

"=====[ UltiSnips Options ]===============================================
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
let g:UltiSnipsSnippetDirectories=["Ultisnips"]

"=====[ Nerdtree Options ]===============================================
let g:NERDCreateDefaultMappings=1
let g:NERDCompactSexyComs=1
let g:NERDTreeMinimalUI=0

"=====[ Tagbar Options ]===============================================
let g:tagbar_compact=0
let g:tagbar_autoshowtag=0
nnoremap <silent> <Leader>b :TagbarToggle<CR>

"=====[ Session Options ]===============================================
let g:session_autoload="no"
let g:session_autosave="yes"
let g:session_command_aliases=1
let g:session_default_name="default"
let g:session_directory="~/.vim/sessions"

"=====[ YouCompleteMe Options ]===============================================
"
nnoremap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_extra_conf_globlist = ['~/code/*','!~/*']
let g:ycm_autoclose_preview_window_after_completion = 1
" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<c-j>', '<Down>']
let g:ycm_key_list_previous_completion = ['<c-k>', '<Up>']

let g:ycm_register_as_syntastic_checker = 1 "default 1
let g:Show_diagnostics_ui = 1 "default 1

"will put icons in Vim's gutter on lines that have a diagnostic set.
"Turning this off will also turn off the YcmErrorLine and YcmWarningLine
"highlighting
let g:ycm_enable_diagnostic_signs = 1
let g:ycm_enable_diagnostic_highlighting = 1
let g:ycm_always_populate_location_list = 1 "default 0
let g:ycm_open_loclist_on_ycm_diags = 1 "default 1

let g:ycm_complete_in_strings = 1 "default 1
let g:ycm_collect_identifiers_from_tags_files = 0 "default 0
let g:ycm_path_to_python_interpreter = '' "default ''

let g:ycm_server_use_vim_stdout = 0 "default 0 (logging to console)
let g:ycm_server_log_level = 'info' "default info

let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'  "where to search for .ycm_extra_conf.py if not found
let g:ycm_confirm_extra_conf = 1

let g:ycm_goto_buffer_command = 'same-buffer' "[ 'same-buffer', 'horizontal-split', 'vertical-split', 'new-tab' ]
let g:ycm_filetype_whitelist = { '*': 1 }
let g:ycm_key_invoke_completion = '<C-Space>'

"=====[ Supertab Options ]===============================================
let g:SuperTabDefaultCompletionType = '<c-j>'
let g:SuperTabCrMapping = 0

"=====[ UltiSnips Options ]===============================================
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
let g:UltiSnipsSnippetDirectories=["Ultisnips"]

"=====[ Multi cursors Options ]===============================================

"let g:multi_cursor_use_default_mapping=0
"let g:multi_cursor_next_key='<C-n>'
"let g:multi_cursor_prev_key='<C-p>'
"let g:multi_cursor_skip_key='<C-x>'
"let g:multi_cursor_quit_key='<esc>'
"
"=====[ Nerdtree Options ]===============================================
let g:NERDCreateDefaultMappings=1
let g:NERDCompactSexyComs=1
let g:NERDTreeMinimalUI=0
nnoremap <silent> <Leader>nt :NERDTree<cr>

"=====[ Tagbar Options ]===============================================
let g:tagbar_compact=0
let g:tagbar_autoshowtag=0
nnoremap <silent> <Leader>tb :TagbarToggle<CR>

"=====[ Session Options ]===============================================
let g:session_autoload="no"
let g:session_autosave="yes"
let g:session_command_aliases=1
let g:session_default_name="default"
let g:session_directory="~/.vim/sessions"

"=====[ Delimitmate Options ]===============================================
let delimitMate_expand_cr = 2
let delimitMate_expand_space = 1
"let delimitMate_matchpairs = "(:),[:],{:},<:>"
imap <leader><tab> <Plug>delimitMateS-Tab

"=====[ CtrlP Options ]===============================================
"let g:ctrlp_custom_ignore = {
""  \ 'dir':   '\v(\.(git|hg|svn)$|build$|debug$|release$)',
""  \ 'file':  '\v\.(so|swp|zip|a)$',
""  \ }
"nnoremap <silent> <Leader>t :CtrlP<cr>
"nnoremap <silent> <leader>T :ClearCtrlPCache<cr>\|:CtrlP<cr>
"nnoremap <leader>. :CtrlPTag<cr>

"=====[ Remove all the rubbish from gvim]====================================

set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guifont=Terminess\ Powerline "Set the GVIM font to terminus

"" Get rid of the arrow keys!
map <F3> :Autoformat<CR>
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

"" This will be useful for long lines in Latex files
nnoremap j gj
nnoremap k gk
nnoremap Q <nop>


"" Easy window navigation
"map <C-h> <C-w>h
"map <C-j> <C-w>j
"map <C-k> <C-w>k
"map <C-l> <C-w>l
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guifont=Terminess\ Powerline "Set the GVIM font to terminus

"" Get rid of the arrow keys!
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

"" This will be useful for long lines in Latex files
nnoremap j gj
nnoremap k gk
nnoremap Q <nop>


"" Easy window navigation
"map <C-h> <C-w>h
"map <C-j> <C-w>j
"map <C-k> <C-w>k
"map <C-l> <C-w>l

"" Clear search with ./
nmap <silent> <leader>/ :nohlsearch<CR>

" Write as super user (If you accidentally opened as normal user)
cmap w!! w !sudo tee % >/dev/null

imap jk <esc>

runtime plugin/dragvisuals.vim
vmap  <expr>  <LEFT>   DVB_Drag('left')
vmap  <expr>  <RIGHT>  DVB_Drag('right')
vmap  <expr>  <DOWN>   DVB_Drag('down')
vmap  <expr>  <UP>     DVB_Drag('up')
vmap  <expr>  D        DVB_Duplicate()

" Remove any introduced trailing whitespace after moving...     ##
let g:DVB_TrimWS = 1

"" Clear search with ./
nmap <silent> <leader>/ :nohlsearch<CR>

" Write as super user (If you accidentally opened as normal user)
cmap w!! w !sudo tee % >/dev/null
exec "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:~"
set list

inoremap jk <esc>

runtime plugin/dragvisuals.vim
vmap  <expr>  <LEFT>   DVB_Drag('left')
vmap  <expr>  <RIGHT>  DVB_Drag('right')
vmap  <expr>  <DOWN>   DVB_Drag('down')
vmap  <expr>  <UP>     DVB_Drag('up')
vmap  <expr>  D        DVB_Duplicate()
nnoremap  ;  :

" Remove any introduced trailing whitespace after moving...     ##
let g:DVB_TrimWS = 1

"====[ Make tabs, trailing whitespace, and non-breaking spaces visible ]======

exec "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:~"
set list

"====[ Swap : and ; to make colon commands easier to type ]======

nnoremap  ;  :

"====[ Swap v and CTRL-V, because Block mode is more useful that Visual mode "]======

nnoremap    v   <C-V>
nnoremap <C-V>     v

vnoremap    v   <C-V>
vnoremap <C-V>     v

"====[ Mappings to activate spell-checking alternatives ]================

nmap  ;s     :set invspell spelllang=en<CR>

" To create the en-basic (or any other new) spelling list:
"
"     :mkspell  ~/.vim/spell/en-basic  basic_english_words.txt
"
" See :help mkspell
"

function! MarkWindowSwap()
    let g:markedWinNum = winnr()
endfunction

function! DoWindowSwap()
    "Mark destination
    let curNum = winnr()
    let curBuf = bufnr( "%" )
    exe g:markedWinNum . "wincmd w"
    "Switch to source and shuffle dest->source
    let markedBuf = bufnr( "%" )
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' curBuf
    "Switch to dest and shuffle source->dest
    exe curNum . "wincmd w"
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' markedBuf 
endfunction

nmap <silent> <leader>mw :call MarkWindowSwap()<CR>
nmap <silent> <leader>pw :call DoWindowSwap()<CR>
    " To create the en-basic (or any other new) spelling list:
    "
    "     :mkspell  ~/.vim/spell/en-basic  basic_english_words.txt
    "
    " See :help mkspell

"====[ Make CTRL-K list diagraphs before each digraph entry ]===============

"inoremap <expr>  <c-n>   BDG_GetDigraph() 

"====[ Fix syntax highlighting for shader files ]===========================
au BufNewFile,BufRead *.glslf,*.glslv,*.frag,*.vert,*.glsl SetGLSLFileType

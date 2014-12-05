set nocompatible
let mapleader=","

filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

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
set ttyscroll=5
set nottyfast
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

"====[ Vundle! ]===========================
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
Plugin 'jalcine/cmake.vim'
Plugin 'tpope/vim-ragtag'
Plugin 'airblade/vim-rooter'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-repeat'
Plugin 'mhinz/vim-signify'
Plugin 'ervandew/supertab'
Plugin 'tpope/vim-sensible.git'
"Plugin 'godlygeek/tabular'
Plugin 'xolox/vim-session'

" unite add ons
Plugin 'tsukkee/unite-tag'
Plugin 'yuku-t/unite-git'

" editor add ons
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'majutsushi/tagbar'
Plugin 'bling/vim-airline'
Plugin 'terryma/vim-multiple-cursors'

"Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'Lokaltog/powerline-fonts'
Plugin 'scrooloose/syntastic'

Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
" Plugin 'kien/ctrlp.vim'
Plugin 'Valloric/YouCompleteMe'

" version control
Plugin 'tpope/vim-fugitive'

" languages
Plugin 'sheerun/vim-polyglot'
Plugin 'git://git.code.sf.net/p/vim-latex/vim-latex'
Plugin 'lambdatoast/elm.vim'
Plugin 'petRUShka/vim-opencl'
Plugin 'beyondmarc/glsl.vim'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'othree/html5-syntax.vim'
Plugin 'tpope/vim-markdown'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'tpope/vim-haml'
Plugin 'jQuery'
Plugin 'derekwyatt/vim-scala'
Plugin 'dbakker/vim-lint'

"Colours
Plugin 'jnurmine/Zenburn'
Plugin 'Yggdroot/indentLine'

colorscheme zenburn
" Enable syntax highlighting
syntax on
"And indenting
filetype plugin indent on

" Unite functions

func! s:call_unite(sources)
"exec(':Unite -no-split -direction=botright -unique -truncate -sync ' . a:sources)
exec(':Unite -direction=botright -unique -truncate -sync ' . a:sources)
endfunc

func! s:call_unite_tasks()
  call s:call_unite('grep:.:-s:\(TODO\|todo\|NOTE\|note\|' .
\ 'FIXME\|fixme\|BUG\|bug)')
endfunc

func! s:call_unite_tmux()
call s:call_unite('tmux/panes tmux/sessions tmux/windows ' .
\ 'tmuxcomplete/lines')
endfunc
func! s:call_unite_tags()
  call s:call_unite('tag tag/include')
endfunc
func! s:call_unite_buffer()
  call s:call_unite('buffer')
endfunc
func! s:call_unite_files()
  return s:call_unite('file_rec/async:!:$PWD file_rec/git:!')
endfunc
func! s:call_unite_local_grep()
  return s:call_unite('grep:.:-R')
endfunc
func! s:call_unite_resume()
  return s:call_unite('resume')
endfunc

" Define a base mapping for Unite.
nnoremap [unite] <nop>
nmap <leader>u [unite]
" Define the mappings.
nnoremap <silent> [unite]b :call <SID>call_unite_buffer()<cr>
nnoremap <silent> [unite]f :call <SID>call_unite_files()<cr>
nnoremap <silent> [unite]g :call <SID>call_unite_local_grep()<cr>
nnoremap <silent> [unite]t :call <SID>call_unite_tags()<cr>
"nnoremap <silent> [unite]t :call <SID>call_unite_tasks()<cr>
nnoremap <silent> [unite]x :call <SID>call_unite_tmux()<cr>
nnoremap <silent> [unite]r :call <SID>call_unite_resume()<cr>
nnoremap <silent> [unite]X :call <Plug>unite_disable_max_candidates()<CR>
" For those who end up using my machine but think it has CtrlP.
nnoremap <silent> <leader>p [unite]f
" }}}
" {{{ Git helpers
nnoremap <leader>ga :Git add<space>
nnoremap <leader>gab :Git add %<cr>
nnoremap <leader>gc :Git commit<space>
nnoremap <leader>gco :Git checkout<space>
nnoremap <leader>gf :Git fetch<space>
nnoremap <leader>gfa :Git fetch --all<CR>
nnoremap <leader>gp :Git push<space>
nnoremap <leader>grm :Git rm %<CR>
nnoremap <leader>grmc :Git rm --cached %<CR>
" }}}

if (exists('unite#set_profile'))
  call unite#filters#matcher_default#use(['matcher_regexp'])
  call unite#filters#sorter_default#use(['sorter_rank'])
  call unite#set_profile('files', 'smartcase', 1)
  autocmd FileType unite call s:configure_unite_buffer()
  func! s:configure_unite_buffer()
    imap <buffer> <C-j> <Plug>(unite_select_next_line)<CR>
    imap <buffer> <C-k> <Plug>(unite_select_previous_line)<CR>
    imap <buffer> <C-p> <Plug>(unite_auto_preview)<CR>
  endfunc
endif

"set tags='.git/tags'
"./tags,./TAGS,./.git/tags
"if isdirectory('~/.tags')
"  let tagfiles = expand('~/.tags/**/*.tags', 0, 1)
"  for atagfile in tagfiles
"    let &tags .= ',' . fnamemodify(atagfile,':p:.')
"  endfor
"endif

"=====[ c/c++ Options ]===============================================
    let g:load_doxygen_syntax=1
    let g:doxygen_enhanced_color=1
    let g:c_comment_strings=1
    let g:c_curly_errors=1
    let g:c_gnu=0
    let g:c_no_c99=1
    let g:c_space_errors=1

"=====[ Airline Options ]===============================================
    let g:airline_theme='base16'
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

"=====[ Powerline Options ]===============================================
let g:Powerline_symbols = 'fancy'

"=====[ YouCompleteMe Options ]===============================================

let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_extra_conf_globlist = ['~/code/*','!~/*']
let g:ycm_autoclose_preview_window_after_insertion = 1
" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<c-j>', '<Down>']
let g:ycm_key_list_previous_completion = ['<c-k>', '<Up>']

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

"=====[ Syntastic Options ]===============================================
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=1
let g:syntastic_aggregate_errors=1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_enable_ballons=has('ballon_eval')
let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_jump=0
let g:syntastic_auto_loc_list=1
let g:syntastic_loc_list_height=3
let g:syntastic_ignore_files = ['\m^/usr/include/', 'node_modules']
let g:syntastic_mode_map = { 'mode': 'active' }
" {{{ Checkers for Syntastic
let g:syntastic_javascript_checkers=['jslint', 'jscs']
let g:syntastic_json_checkers=['jsonlint', 'jsonval']
let g:syntastic_ruby_checkers=['mri', 'rubocop']
let g:syntastic_perl_checkers=['perl','perlcritic','podchecker']
let g:syntastic_python_checkers=['pylint','pep8','python']
let g:syntastic_cpp_checkers=['gcc','cppcheck','cpplint']
let g:syntastic_c_checkers=['gcc','make','cppcheck']
let g:syntastic_haml_checkers=['haml_lint', 'haml']
let g:syntastic_sh_checkers=['sh','shellcheck','checkbashisms']
let g:syntastic_vim_checkers=['vimlint']
" }}}
let g:syntastic_ruby_exec=substitute(system('which ruby'),'\n','','g')
let g:syntastic_yaml_checkers=['jsyaml']
let g:syntastic_jshint_exe='jshint'
let g:syntastic_enable_perl_checker=1

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

"=====[ Delimitmate Options ]===============================================
let delimitMate_expand_cr = 2
let delimitMate_expand_space = 1
imap <leader><tab> <Plug>delimitMateS-Tab

"=====[ CtrlP Options ]===============================================
let g:ctrlp_custom_ignore = {
  \ 'dir':   '\v(\.(git|hg|svn)$|build$|debug$|release$)',
  \ 'file':  '\v\.(so|swp|zip|a)$',
  \ }
nnoremap <silent> <Leader>t :CtrlP<cr>
nnoremap <silent> <leader>T :ClearCtrlPCache<cr>\|:CtrlP<cr>
nnoremap <leader>. :CtrlPTag<cr>

"=====[ Remove all the rubbish from gvim]====================================

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

inoremap jk <esc>
xnoremap jk <esc>

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


"====[ Make CTRL-K list diagraphs before each digraph entry ]===============

"inoremap <expr>  <c-n>   BDG_GetDigraph() 

"====[ Fix syntax highlighting for shader files ]===========================
au BufNewFile,BufRead *.glslf,*.glslv,*.frag,*.vert,*.glsl SetGLSLFileType

"execute pathogen#infect()

let mapleader = ","

set nocompatible
filetype off

" Escape and CTRL-C clear highlighting
nnoremap <esc> :noh<return><esc>
nnoremap <C-c> :noh<return><esc>

let g:php_cs_fixer_path = "/usr/local/bin/php-cs-fixer" " define the path to the php-cs-fixer.phar
let g:php_cs_fixer_level = "all"                " which level ?
let g:php_cs_fixer_config = "default"           " configuration
let g:php_cs_fixer_php_path = "php"             " Path to PHP
let g:php_cs_fixer_fixers_list = ""             " List of fixers
let g:php_cs_fixer_enable_default_mapping = 1   " Enable the mapping by default (<leader>pcd)
let g:php_cs_fixer_dry_run = 0                  " Call command with dry-run option
let g:php_cs_fixer_verbose = 0                  " Return the output of command if 1, else an inline information.

" Don't show dumb highlighting on so called spelling mistakes
hi clear SpellBad
" Use subtle underline instead
hi SpellBad cterm=underline

" Powerline fancy patched font goodness
let g:Powerline_symbols = 'fancy'

" This line fixes transparent background
hi Normal ctermbg=NONE

" This is for lusty juggler
set hidden

" Vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Symfony
let g:symfony_app_console_caller= "php"
let g:symfony_app_console_path= "app/console"

" Include the bundles file

if filereadable(expand("~/.vimrc.bundles"))
    source ~/.vimrc.bundles
endif


filetype plugin indent on


""
"" Helpers
""

" Some file types should wrap their text
function! s:setupWrapping()
  set wrap
  set linebreak
  set textwidth=72
  set nolist
endfunction

""
"" File types
""

filetype plugin indent on " Turn on filetype plugins (:help filetype-plugin)

if has("autocmd")
  " In Makefiles, use real tabs, not tabs expanded to spaces
  au FileType make setlocal noexpandtab

  " Make sure all mardown files have the correct filetype set and setup wrapping
  au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn,txt} setf markdown | call s:setupWrapping()

  " Treat JSON files like JavaScript
  au BufNewFile,BufRead *.json set ft=javascript

  " make Python follow PEP8 for whitespace ( http://www.python.org/dev/peps/pep-0008/ )
  au FileType python setlocal softtabstop=4 tabstop=4 shiftwidth=4

  " Remember last location in file, but not for commit messages.
  " see :help last-position-jump
  au BufReadPost * if &filetype !~ '^git\c' && line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g`\"" | endif
endif


""
"" General Mappings (Normal, Visual, Operator-pending)
""

" use :w!! to write to a file using sudo if you forgot to 'sudo vim file'
" (it will prompt for sudo password when writing)
cmap w!! %!sudo tee > /dev/null %

" Toggle paste mode
"nmap <silent> <F4> :set invpaste<CR>:set paste?<CR>
"imap <silent> <F4> <ESC>:set invpaste<CR>:set paste?<CR>

" format the entire file
nmap <leader>fef ggVG=

" upper/lower word
nmap <leader>u mQviwU`Q
nmap <leader>l mQviwu`Q

" upper/lower first char of word
nmap <leader>U mQgewvU`Q
nmap <leader>L mQgewvu`Q

" cd to the directory containing the file in the buffer
nmap <silent> <leader>cd :lcd %:h<CR>

" Create the directory containing the file in the buffer
"nmap <silent> <leader>md :!mkdir -p %:p:h<CR>

" Some helpers to edit mode
" http://vimcasts.org/e/14
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

" Swap two words
nmap <silent> gw :s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR>`'

" Underline the current line with '='
nmap <silent> <leader>ul :t.\|s/./=/g\|:nohls<cr>

" set text wrapping toggles
nmap <silent> <leader>tw :set invwrap<CR>:set wrap?<CR>

" find merge conflict markers
nmap <silent> <leader>fc <ESC>/\v^[<=>]{7}( .*\|$)<CR>

" Map the arrow keys to be based on display lines, not physical lines
map <Down> gj
map <Up> gk

" Toggle hlsearch with <leader>hs
nmap <leader>hs :set hlsearch! hlsearch?<CR>

" Adjust viewports to the same size
map <Leader>= <C-w>=

if has("gui_macvim") && has("gui_running")
  " Map command-[ and command-] to indenting or outdenting
  " while keeping the original selection in visual mode
  vmap <D-]> >gv
  vmap <D-[> <gv

  nmap <D-]> >>
  nmap <D-[> <<

  omap <D-]> >>
  omap <D-[> <<

  imap <D-]> <Esc>>>i
  imap <D-[> <Esc><<i

  " Bubble single lines
  nmap <D-Up> [e
  nmap <D-Down> ]e
  nmap <D-k> [e
  nmap <D-j> ]e

  " Bubble multiple lines
  vmap <D-Up> [egv
  vmap <D-Down> ]egv
  vmap <D-k> [egv
  vmap <D-j> ]egv

  " Map Command-# to switch tabs
  map  <D-0> 0gt
  imap <D-0> <Esc>0gt
  map  <D-1> 1gt
  imap <D-1> <Esc>1gt
  map  <D-2> 2gt
  imap <D-2> <Esc>2gt
  map  <D-3> 3gt
  imap <D-3> <Esc>3gt
  map  <D-4> 4gt
  imap <D-4> <Esc>4gt
  map  <D-5> 5gt
  imap <D-5> <Esc>5gt
  map  <D-6> 6gt
  imap <D-6> <Esc>6gt
  map  <D-7> 7gt
  imap <D-7> <Esc>7gt
  map  <D-8> 8gt
  imap <D-8> <Esc>8gt
  map  <D-9> 9gt
  imap <D-9> <Esc>9gt
else
  " Map command-[ and command-] to indenting or outdenting
  " while keeping the original selection in visual mode
  vmap <A-]> >gv
  vmap <A-[> <gv

  nmap <A-]> >>
  nmap <A-[> <<

  omap <A-]> >>
  omap <A-[> <<

  imap <A-]> <Esc>>>i
  imap <A-[> <Esc><<i

  " Bubble single lines
  nmap <C-Up> [e
  nmap <C-Down> ]e
  nmap <C-k> [e
  nmap <C-j> ]e

  " Bubble multiple lines
  vmap <C-Up> [egv
  vmap <C-Down> ]egv
  vmap <C-k> [egv
  vmap <C-j> ]egv

  " Make shift-insert work like in Xterm
  map <S-Insert> <MiddleMouse>
  map! <S-Insert> <MiddleMouse>

  " Map Control-# to switch tabs
  map  <C-0> 0gt
  imap <C-0> <Esc>0gt
  map  <C-1> 1gt
  imap <C-1> <Esc>1gt
  map  <C-2> 2gt
  imap <C-2> <Esc>2gt
  map  <C-3> 3gt
  imap <C-3> <Esc>3gt
  map  <C-4> 4gt
  imap <C-4> <Esc>4gt
  map  <C-5> 5gt
  imap <C-5> <Esc>5gt
  map  <C-6> 6gt
  imap <C-6> <Esc>6gt
  map  <C-7> 7gt
  imap <C-7> <Esc>7gt
  map  <C-8> 8gt
  imap <C-8> <Esc>8gt
  map  <C-9> 9gt
  imap <C-9> <Esc>9gt
endif

""
"" Command-Line Mappings
""

" Insert the current directory into a command-line path
cmap <C-P> <C-R>=expand("%:p:h") . "/"<CR>


""
"" Basic Setup
""

set nocompatible      " Use vim, no vi defaults
set number            " Show line numbers
set ruler             " Show line and column number
syntax enable         " Turn on syntax highlighting allowing local overrides
set encoding=utf-8    " Set default encoding to UTF-8

""
"" Whitespace
""

set nowrap                        " don't wrap lines
set expandtab                     " use spaces, not tabs
set list                          " Show invisible characters
set backspace=indent,eol,start    " backspace through everything in insert mode

set shiftwidth=4                " use indents of 4 spaces
set tabstop=4                   " an indentation every four columns
set softtabstop=4               " let backspace delete indent

if exists("g:enable_mvim_shift_arrow")
  let macvim_hig_shift_movement = 1 " mvim shift-arrow-keys
endif

" List chars
set listchars=""                  " Reset the listchars
set listchars=tab:\ \             " a tab should display as "  ", trailing whitespace as "."
set listchars+=trail:.            " show trailing spaces as dots
set listchars+=extends:>          " The character to show in the last column when wrap is
                                  " off and the line continues beyond the right of the screen
set listchars+=precedes:<         " The character to show in the last column when wrap is
                                  " off and the line continues beyond the right of the screen

""
"" Searching
""

set hlsearch    " highlight matches
set incsearch   " incremental searching
set ignorecase  " searches are case insensitive...
set smartcase   " ... unless they contain at least one capital letter
set magic       " change the way backslashes are used in search patterns

""
"" Wild settings
""

" TODO: Investigate the precise meaning of these settings
" set wildmode=list:longest,list:full

" Disable output and VCS files
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem

" Disable archive files
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz

" Ignore bundler and sass cache
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*

" Disable temp and backup files
set wildignore+=*.swp,*~,._*

" Disable Symfony cache files
set wildignore+=*/app/cache/*

" Disable Smarty cache files
set wildignore+=*/templates_c/*

""
"" Backup and swap files
""

set backupdir=~/.vim/_backup//    " where to put backup files.
set directory=~/.vim/_temp//      " where to put swap files.

""
" statusline
""
if has("statusline") && !&cp
  set laststatus=2  " always show the status bar

  " Start the status line
  set statusline=%f\ %m\ %r
  set statusline+=Line:%l/%L[%p%%]
  set statusline+=Col:%v
  set statusline+=Buf:#%n
  set statusline+=[%b][0x%B]
endif

" File formats
set fileformat=unix     " file mode is unix
set fileformats=unix,dos,mac   " detects unix, dos, mac file formats in that order


" Slicker quicker window navigation
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-l> :wincmd l<CR>

"nmap <C-o> :ZoomWin<CR>
"nmap = 2<C-W>+
"nmap - 2<C-W>-

" Window navigation with stacking horizontal splits
"map <C-J> <C-W>j<C-W>_
"map <C-K> <C-W>k<C-W>_
"map <C-L> <C-W>l<C-W>_
"map <C-H> <C-W>h<C-W>_


" Min height for each window - allows stacking when using C-k and C-j
"set winminheight=0
"
" Map gundo to ,g
map <leader>g :GundoToggle<CR>

" Undotree
map <leader>u :UndotreeToggle<CR>

" Tagbar
map <leader>rt :TagbarToggle<CR>
" Open Tagbar on Vim start
"autocmd vimenter * TagbarOpen
"autocmd VimEnter * nested :TagbarOpen
let g:tagbar_width = 30
let g:tagbar_compact = 1
let g:tagbar_iconchars = ['▾', '▸']

" Map  yankring show to ,y yankring search to ,,y
"map <leader>y :YRShow<CR>
"map <leader><leader>y :YRSearch<CR>

" ctrlp remap mixed mode to CTRL+T
let g:ctrlp_map = '<C-t>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_root_markers = ['.projectroot']
map <C-b> :CtrlPBuffer<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                yankring                                 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:yankring_history_dir = '$HOME/tmp/vim'
" this is so that single char deletes don't end up in the yankring
let g:yankring_min_element_length = 2
let g:yankring_window_height = 14
nnoremap <leader>yr :YRShow<CR>

" this makes Y yank from the cursor to the end of the line, which makes more
" sense than the default of yanking the whole current line (we can use yy for
" that)
function! YRRunAfterMaps()
    nnoremap Y   :<C-U>YRYankCount 'y$'<CR>
endfunction

" Yankstack mappings
"nmap <C-p> <Plug>yankstack_substitute_older_paste
"nmap <C-n> <Plug>yankstack_substitute_newer_paste
"map <leader>y :Yanks<CR>

" Gitv
nmap <leader>gv :Gitv --all<cr>
nmap <leader>gV :Gitv! --all<cr>
vmap <leader>gV :Gitv! --all<cr>

" MySQLRun
"map <leader>my :MySQLRun<CR>

" VimCalc
"map <leader>cl :Calc<CR>

" ReTab and StripWhiteSpaces
map <leader>rr :retab<CR> :StripWhiteSpaces<CR>

" New Tab ,ot
map <leader>ot :tabe<CR>

" Close Tab ,ct
map <leader>ct :tabclose<CR>

" Fix ack-grep link
let g:ackprg="ack-grep -H --nocolor --nogroup --column"

" Use tab to cycle tabs
map <Tab> gt
map <S-Tab> gT

" Symfony
map <leader>s :execute ":!"g:symfony_enable_shell_cmd<CR>

" Set paste toggle
"nmap <silent> <leader>pp :set invpaste<CR>:set paste?<CR>
"imap <silent> <leader>pp <ESC>:set invpaste<CR>:set paste?<CR>
set pastetoggle=<F7>

" visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" Stupid shift key fixes
cmap W w
cmap WQ wq
cmap wQ wq
cmap Q q
cmap Tabe tabe

" Minimum lines to keep above and below cursor
set scrolloff=3

" Colorscheme stuff
set background=dark
let g:solarized_termtrans=1
let g:solarized_termcolors=256
let g:solarized_contrast="high"
let g:solarized_visibility="high"

" Colour scheme
colorscheme solarized

set showmatch           " show matching bracket (briefly jump)
set matchtime=2         " reduces matching paren blink time from the 5[00]ms def

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               NERDTree                                  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>n :NERDTreeToggle<CR>
map <leader>m :NERDTreeFind<CR>
let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
let NERDTreeChDirMode=0
let NERDTreeQuitOnOpen=0
let nerdtreeshowhidden=1
let nerdtreekeeptreeinnewtab=1
let NERDTreeMinimalUI=1

" Quit Vim if nerdtree is last window open
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" Open nerdtree on Vim start if no file specified
"autocmd vimenter * if !argc() | NERDTree | endif
" Open nerdtree on Vim start
"autocmd vimenter * NERDTree

" HTML Autoclosetag
au FileType html.twig,xhtml,xml,smarty so ~/.vim/bundle/HTML-AutoCloseTag/ftplugin/html_autoclosetag.vim

" Gui font, profont
if has("gui_running")
    if has("macunix")
        set guifont=ProFont:h9
    elseif has("win32")
        set guifont=ProFontWindows:h11:b:cANSI,Lucida_Console:h11:b:cANSI
    elseif has("x11")
        set guifont=-jmk-neep-bold-r-normal--15-*-*-*-*-*-*-*
    endif
endif

" Show horizontal cursor
set cursorline

" Fix home and end keybindings for screen, particularly on mac
" - for some reason this fixes the arrow keys too. huh.
map [F $
imap [F $
map [H g0
imap [H g0

" disable folding
set nofoldenable
set foldlevelstart=99
set foldlevel=99
let g:DisableAutoPHPFolding = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               PHPDebug                                 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <F5> :python debugger_run()<cr>

" For snippet_complete marker.
if has('conceal')
    set conceallevel=2 concealcursor=i
endif

" always switch to the current file directory.
autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              SpeedDating                                "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap  <C-M>     <Plug>SpeedDatingUp
nmap  <C-X>     <Plug>SpeedDatingDown
xmap  <C-M>     <Plug>SpeedDatingUp
xmap  <C-X>     <Plug>SpeedDatingDown

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                PHPCtags                                 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:tagbar_phpctags_bin='/home/gez/bin/phpctags'

" Navigate back from tags jump
nmap <C-[> :pop<CR>

" Do not make tabs show as red
highlight RedundantWhitespace ctermbg=234 guibg=234
match RedundantWhitespace /\s\+$\|\t/

" Bufstop
"map <C-b> :BufstopFast<CR>             " get a visual on the buffers
"map <leader>b :Bufstop<CR>             " get a visual on the buffers
"let g:BufstopAutoSpeedToggle = 1       " now I can press ,3,3,3 to cycle the last 3 buffers

" Disable PHP CodeSniffer
let g:syntastic_phpcs_disable = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                Vimpanel                                 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>ss :VimpanelSessionMake<CR>
map <leader>sl :VimpanelSessionLoad<CR>
cabbrev vp Vimpanel
cabbrev vl VimpanelLoad
cabbrev vc VimpanelCreate
cabbrev ve VimpanelEdit
cabbrev vr VimpanelRemove

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                Fugitive                                 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>gs :Gstatus<CR>
map <leader>gc :Gcommit<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                Tagbar                                   "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:tagbar_type_markdown = {
    \ 'ctagstype' : 'markdown',
    \ 'kinds' : [
        \ 'h:Heading_L1',
        \ 'i:Heading_L2',
        \ 'k:Heading_L3'
    \ ]
\ }

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                session                                  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" you also need to run :SaveSession once to create the default.vim session that
" will then be autoloaded/saved from then on

let g:session_autoload        = 'yes'
let g:session_autosave        = 'yes'
let g:session_default_to_last = 'yes'
let g:session_directory       = '~/tmp/vim/sessions'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                phpDoc                                   "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:pdv_cfg_Author = "Gez Page <gezpage@gmail.com>"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            MatchTagAlways                               "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:mta_filetypes = {
    \ 'html' : 1,
    \ 'xhtml' : 1,
    \ 'xml' : 1,
    \ 'jinja' : 1,
    \ 'html.twig' : 1,
    \}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                bufkill                                  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use the arrows for something useful
" :BB switches to the previous buffer shown in the current window, :BF switches
" to the next one; it's like a buffer history for every window
noremap <right> :BF<cr>
noremap <left> :BB<cr>

" tries to avoid those annoying "hit enter to continue" messages
" if it still doesn't help with certain commands, add a second <cr>
" at the end of the map command
set shortmess=a

" none of these should be word dividers, so make them not be
set iskeyword+=_,$,@,%,#


" TODO: split this into separate plugin
function! VisualSearch(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        execute "Ack " . l:pattern . ' %'
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

"Basically you press * or # to search for the current selection
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>
vnoremap <silent> gv :call VisualSearch('gv')<CR>

" These create newlines like o and O but stay in normal mode
nnoremap <silent> zj o<Esc>k
nnoremap <silent> zk O<Esc>j

" Keep search matches in the middle of the window.
" zz centers the screen on the cursor, zv unfolds any fold if the cursor
" suddenly appears inside a fold.
nnoremap * *zzzv
nnoremap # #zzzv
nnoremap n nzzzv
nnoremap N Nzzzv
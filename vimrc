let mapleader = ","

" Line numbers
set number
syntax on
" Plugins
:filetype plugin on
" Autoindent
set autoindent
"color column
"set colorcolumn=80

"clipboard
"set clipboard=unnamed
"tmux clipboard
if $TMUX == ''
  set clipboard+=unnamed
endif

" jk para salir de insert mode
imap jk <Esc>

" User the Source Code Pro font
set anti enc=utf-8 gfn=Source_Code_Pro_for_Powerline:h12,Menlo:h14,Monaco:h14

"no swap files
set noswapfile
set nobackup
set nowb

"zen coding leader
let g:user_emmet_leader_key = '<leader>'

" filetypes
autocmd BufNewFile, BufRead *.html.erb set filetype=html.eruby.eruby-rails
"autocmd BufNewFile, BufRead *.js.coffee set filetype=coffee
autocmd BufNewFile, BufRead *.js.coffee.* set filetype=coffee.eruby.eruby-rails
au  BufNewFile,BufRead *.mustache,*.handlebars,*.hbs,*.hogan,*.hulk,*.hjs set filetype=mustache syntax=mustache | runtime! ftplugin/mustache.vim ftplugin/mustache*.vim ftplugin/mustache/*.vim

nmap <C-t> :tabedit %<CR>
nmap <C-b> :noh<CR>

" vimrc de github
"avoiding annoying CSApprox warning message
let g:CSApprox_verbose_level = 0

"necessary on some Linux distros for pathogen to properly load bundles
filetype off

"Use Vim settings, rather then Vi settings (much better!).
"This must be first, because it changes other options as a side effect.
set nocompatible

"allow backspacing over everything in insert mode
set backspace=indent,eol,start

set showcmd     "show incomplete cmds down the bottom
set showmode    "show current mode down the bottom

set incsearch   "find the next match as we type the search
set hlsearch    "hilight searches by default

set showbreak=...
set wrap linebreak nolist

"add some line space for easy reading
set linespace=4

"disable visual bell
set visualbell t_vb=

"try to make possible to navigate within lines of wrapped lines
nmap <Down> gj
nmap <Up> gk
set fo=l

"statusline setup
set statusline=%f       "tail of the filename

"Git
set statusline+=%{fugitive#statusline()}

"RVM
set statusline+=%{exists('g:loaded_rvm')?rvm#statusline():''}

set statusline+=%=      "left/right separator
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file
set laststatus=2

"turn off needless toolbar on gvim/mvim
set guioptions-=T

"recalculate the trailing whitespace warning when idle, and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning

"return '[\s]' if trailing white space is detected
"return '' otherwise
function! StatuslineTrailingSpaceWarning()
    if !exists("b:statusline_trailing_space_warning")
        if search('\s\+$', 'nw') != 0
            let b:statusline_trailing_space_warning = '[\s]'
        else
            let b:statusline_trailing_space_warning = ''
        endif
    endif
    return b:statusline_trailing_space_warning
endfunction


"return the syntax highlight group under the cursor ''
function! StatuslineCurrentHighlight()
    let name = synIDattr(synID(line('.'),col('.'),1),'name')
    if name == ''
        return ''
    else
        return '[' . name . ']'
    endif
endfunction

"recalculate the tab warning flag when idle and after writing
autocmd cursorhold,bufwritepost * unlet! b:statusline_tab_warning

"return '[&et]' if &et is set wrong
"return '[mixed-indenting]' if spaces and tabs are used to indent
"return an empty string if everything is fine
function! StatuslineTabWarning()
    if !exists("b:statusline_tab_warning")
        let tabs = search('^\t', 'nw') != 0
        let spaces = search('^ ', 'nw') != 0

        if tabs && spaces
            let b:statusline_tab_warning =  '[mixed-indenting]'
        elseif (spaces && !&et) || (tabs && &et)
            let b:statusline_tab_warning = '[&et]'
        else
            let b:statusline_tab_warning = ''
        endif
    endif
    return b:statusline_tab_warning
endfunction

"recalculate the long line warning when idle and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_long_line_warning

"return a warning for "long lines" where "long" is either &textwidth or 80 (if
"no &textwidth is set)
"
"return '' if no long lines
"return '[#x,my,$z] if long lines are found, were x is the number of long
"lines, y is the median length of the long lines and z is the length of the
"longest line
function! StatuslineLongLineWarning()
    if !exists("b:statusline_long_line_warning")
        let long_line_lens = s:LongLines()

        if len(long_line_lens) > 0
            let b:statusline_long_line_warning = "[" .
                        \ '#' . len(long_line_lens) . "," .
                        \ 'm' . s:Median(long_line_lens) . "," .
                        \ '$' . max(long_line_lens) . "]"
        else
            let b:statusline_long_line_warning = ""
        endif
    endif
    return b:statusline_long_line_warning
endfunction

"return a list containing the lengths of the long lines in this buffer
function! s:LongLines()
    let threshold = (&tw ? &tw : 80)
    let spaces = repeat(" ", &ts)

    let long_line_lens = []

    let i = 1
    while i <= line("$")
        let len = strlen(substitute(getline(i), '\t', spaces, 'g'))
        if len > threshold
            call add(long_line_lens, len)
        endif
        let i += 1
    endwhile

    return long_line_lens
endfunction

"indent settings
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent

set wildmode=list:longest   "make cmdline tab completion similar to bash
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing

"display tabs and trailing spaces
"set list
"set listchars=tab:\ \ ,extends:>,precedes:<
" disabling list because it interferes with soft wrap

set formatoptions-=o "dont continue comments when pushing o/O

"vertical/horizontal scroll off settings
set scrolloff=3
set sidescrolloff=7
set sidescroll=1

"load ftplugins and indent files
filetype plugin on
filetype indent on

"some stuff to get the mouse going in term
set mouse=a
set ttymouse=xterm2

"hide buffers when not displayed
set hidden

if has("gui_running")
    "tell the term has 256 colors
    set t_Co=256

    colorscheme xoria256-pluk "railscasts
    set guitablabel=%M%t
    set lines=40
    set columns=115

    if has("gui_gnome")
        set term=gnome-256color
        colorscheme xoria256-pluk " railscasts
        set guifont=Monospace\ Bold\ 12
    endif

else
    "dont load csapprox if there is no gui support - silences an annoying warning
    let g:CSApprox_loaded = 1

    "set railscasts colorscheme when running vim in gnome terminal
    if $COLORTERM == 'gnome-terminal'
        set term=gnome-256color
        colorscheme xoria256-pluk " railscasts
    else
        if $TERM == 'xterm'
            set term=xterm-256color
            colorscheme xoria256-pluk " railscasts
        else
            colorscheme default
        endif
    endif
endif

"silent! nmap <silent> <Leader>p :NERDTreeToggle<CR>

"make <c-l> clear the highlight as well as redraw
nnoremap <C-L> :nohls<CR><C-L>
inoremap <C-L> <C-O>:nohls<CR>

"map to bufexplorer
nnoremap <leader>b :BufExplorer<cr>

"map to CommandT TextMate style finder
"nnoremap <leader>t :CommandT<CR>
"nnoremap <C-p> :CommandT<CR>

"map Q to something useful
noremap Q gq

"make Y consistent with C and D
nnoremap Y y$

"bindings for ragtag
inoremap <M-o>       <Esc>o
let g:ragtag_global_maps = 1

"mark syntax errors with :signs
let g:syntastic_enable_signs=1

"key mapping for Gundo
nnoremap <F4> :GundoToggle<CR>

"visual search mappings
function! s:VSetSearch()
    let temp = @@
    norm! gvy
    let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
    let @@ = temp
endfunction
vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR>


"jump to last cursor position when opening a file
"dont do it when writing a commit log entry
autocmd BufReadPost * call SetCursorPosition()
function! SetCursorPosition()
    if &filetype !~ 'commit\c'
        if line("'\"") > 0 && line("'\"") <= line("$")
            exe "normal! g`\""
            normal! zz
        endif
    end
endfunction

"define :HighlightLongLines command to highlight the offending parts of
"lines that are longer than the specified length (defaulting to 80)
command! -nargs=? HighlightLongLines call s:HighlightLongLines('<args>')
function! s:HighlightLongLines(width)
    let targetWidth = a:width != '' ? a:width : 79
    if targetWidth > 0
        exec 'match Todo /\%>' . (targetWidth) . 'v/'
    else
        echomsg "Usage: HighlightLongLines [natural number]"
    endif
endfunction

" Strip trailing whitespace
function! <SID>StripTrailingWhitespaces()
    " Preparation save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

"key mapping for window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
"map <C-o> <C-w>o

"key mapping for saving file
nmap <C-s> :w<CR>

"key mapping for tab navigation
nmap <Tab> gt
nmap <S-Tab> gT


"Enabling Zencoding
let g:user_emmet_settings = {
  \  'php' : {
  \    'extends' : 'html',
  \    'filters' : 'c',
  \  },
  \  'xml' : {
  \    'extends' : 'html',
  \  },
  \  'haml' : {
  \    'extends' : 'html',
  \  },
  \  'erb' : {
  \    'extends' : 'html',
  \  },
 \}

" when press { + Enter, the {} block will expand.
imap {<CR> {}<ESC>i<CR><ESC>O

" NERDTree settings
nmap wm :NERDTreeToggle<cr>
let NERDTreeIgnore=['\.swp$']

"nnoremap <Esc>A <up>
"nnoremap <Esc>B <down>
"nnoremap <Esc>C <right>
"nnoremap <Esc>D <left>
"inoremap <Esc>A <up>
"inoremap <Esc>B <down>
"inoremap <Esc>C <right>
"inoremap <Esc>D <left>

" ctrl-p
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_match_window_bottom = 0
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " Linux/MacOSX
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn|log)$'

" command enter
"
let isMac  = has("mac")
let isGui  = has("gui_running")
if(isGui && isMac)
  inoremap <D-Enter> <ESC>o
else
  inoremap ✠ <ESC>o
endif

runtime macros/matchit.vim
if has("autocmd")
  filetype indent plugin on
endif

" vim-seek
let g:seek_enable_jumps = 1
let g:seek_subst_disable = 1

" snipmate
let g:snipMate = {}
let g:snipMate.scope_aliases = {}
let g:snipMate.scope_aliases['javascript'] = 'javascript,javascript-jquery'
let g:snipMate.scope_aliases['ruby'] = 'ruby,ruby-rails,ruby-rspec,ruby-shoulda,ruby-factorygirl,ruby-machinist'
"colorscheme xoria256-pluk " railscasts
"colorscheme lucius
colorscheme putty

"activate powerline
"https://github.com/Lokaltog/powerline/issues/39
"https://github.com/Lokaltog/powerline/issues/39#issuecomment-13035045
"python from powerline.vim import setup as powerline_setup
"python powerline_setup()
"python del powerline_setup

" A Vim function i use to easily toggle colorcolumn on and off.

" If colorcolumn is off and textwidth is set the use colorcolumn=+1.
" If colorcolumn is off and textwidth is not set then use colorcolumn=80.
" If colorcolumn is on then turn it off.

" I use: nmap <Leader>cc :call ColorColumn()<CR>

function! ColorColumn()
  if empty(&colorcolumn)
    if empty(&textwidth)
      echo "colorcolumn=80"
      setlocal colorcolumn=80
    else
      echo "colorcolumn=+1 (" . (&textwidth + 1) . ")"
      setlocal colorcolumn=+1
    endif
  else
    echo "colorcolumn="
    setlocal colorcolumn=
  endif
endfunction

nmap <Leader>co :call ColorColumn()<CR>

"open in sublime
command Subl execute "!subl %"

"mustache abbreviations
let g:mustache_abbreviations = 1

" C-e to go to the end of line in insert mode
inoremap <C-e> <C-o>A

"""""""""""""""""""""""""""""""""""""
"       VUNDLE CONFIGURATION
"""""""""""""""""""""""""""""""""""""
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" PLUGINS
Bundle 'vim-scripts/CSApprox'
Bundle 'vim-scripts/ColorX'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'rking/ag.vim'
Bundle 'lilydjwg/colorizer'
Bundle 'kien/ctrlp.vim'
Bundle 'mattn/emmet-vim'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-haml'
Bundle 'plasticboy/vim-markdown'
Bundle 'mustache/vim-mustache-handlebars'
Bundle 'tpope/vim-ragtag'
Bundle 'tpope/vim-surround'
Bundle 'scrooloose/syntastic'
Bundle 'godlygeek/tabular'
Bundle 'tomtom/tlib_vim'
Bundle 'tpope/vim-unimpaired'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'Townk/vim-autoclose'
Bundle 'asux/vim-capybara'
Bundle 'kchmck/vim-coffee-script'
Bundle 'jnwhiteh/vim-golang'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'henrik/vim-indexed-search'
Bundle 'digitaltoad/vim-jade'
Bundle 'itspriddle/vim-jquery'
Bundle 'matchit.zip'
Bundle 'fundon/vim-mou'
Bundle 'terryma/vim-multiple-cursors'
Bundle 'tpope/vim-rails'
Bundle 'rking/vim-ruby-refactoring'
Bundle 'justinmk/vim-sneak'
Bundle 'garbas/vim-snipmate'
Bundle 'nelstrom/vim-textobj-rubyblock'
Bundle 'kana/vim-textobj-user'
"Bundle 'hwartig/vim-seeing-is-believing'

filetype plugin on     " required!

"nmap <buffer> <F5> <Plug>(seeing-is-believing-run)
"xmap <buffer> <F5> <Plug>(seeing-is-believing-run)
"imap <buffer> <F5> <Plug>(seeing-is-believing-run)

"nmap <buffer> <F4> <Plug>(seeing-is-believing-mark)
"xmap <buffer> <F4> <Plug>(seeing-is-believing-mark)
"imap <buffer> <F4> <Plug>(seeing-is-believing-mark)
filetype off
filetype plugin indent off
set runtimepath+=$GOROOT/misc/vim
filetype plugin indent on
syntax on

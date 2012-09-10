" I use a back background in my editors
set background=dark

filetype plugin  on


" Save jumps and marks by default
set viminfo='100,f1

" I like highlighted search results
set hlsearch
" Use incremental searching
set incsearch

" Set standard setting for PEAR coding standards
set tabstop=4
set shiftwidth=4

" Auto expand tabs to spaces
" set expandtab

" Dont implement VI's bugs
set nocompatible

" No gvim toolbar
set guioptions-=T


set autochdir


" Auto indent after a {
set autoindent
set smartindent

" Linewidth to endless
set textwidth=0

" Do not wrap lines automatically
set nowrap

set showcmd

set laststatus=2

" Show line numbers by default
set number

" Jump 5 lines when running out of the screen
set scrolljump=5

" Indicate jump out of the screen when 3 lines before end of the screen
set scrolloff=3

" Repair wired terminal/vim settings
set backspace=start,eol

"set makeprg=jsl\ -nologo\ -nofilelisting\ -nosummary\ -nocontext\ -conf\ '/etc/jsl.conf'\ -process\ %
"set errorformat=%f(%l):\ %m
"make F10 call make for linting etc.
"inoremap <silent> <F10> <C-O>:make<CR>
"map <silent> <F10> :make<CR>

" Map <CTRL>-B to run PHP parser check
" noremap <C-B> :!php -l %<CR>
" noremap <C-TAB> :e #

:map <C-g> :tag 
" :map <C-H> :set tags=tags<cr>
" :map <C-n> :! "find lib/*.php js/*.js css/*.css -maxdepth 1 -type f | grep -v js_c | grep -v css_c | xargs ctags"<cr>


" Location list navigation
noremap <S-j> :lnext<cr>
noremap <S-k> :lprevious<cr>

" Map zz to space, center around cursor
nmap <space> zz

" :map <C-o> :buffers<cr>

noremap <C-j> <C-d> zz
noremap <C-k> <C-u> zz

set showtabline=2               " File tabs allways visible
:nmap <C-S-tab> :tabprevious<cr>
:nmap <C-tab> :tabnext<cr>
:nmap <C-t> :tabnew<cr>
:map <C-t> :tabnew<cr>
:map <C-S-tab> :tabprevious<cr>
:map <C-tab> :tabnext<cr>
:map <C-q> :tabclose<cr>
" :map <C-w> :tabclose<cr>
:imap <C-S-tab> <ESC>:tabprevious<cr>i
:imap <C-tab> <ESC>:tabnext<cr>i
:imap <C-t> <ESC>:tabnew<cr>

:imap <C-space> <C-x><C-u>
" Trying to unlearn this..
" :map <S-Right> :tabnext<cr>
" :map <S-Left> :tabprevious<cr>
" :imap <S-Left> <ESC>:tabprevious<cr>i
" :imap <S-Right> <ESC>:tabnext<cr>i

" “”“”“”“”“”“”“”“”“”“”“”“”“”“”"
" Eclim Settings
" “”“”“”“”“”“”“”“”“”“”“”“”“”“”"
" "use default Taglist instead of Eclim, avoid problem
let g:EclimTaglistEnabled=0
" “let g:taglisttoo_disabled = 1 ”maybe of the same use of the above command 
" "if the current file is in a Eclipse project, open project tree
" automatically
let g:EclimProjectTreeAutoOpen=1 
let g:EclimProjectTreeExpandPathOnOpen=1
let g:EclimProjectTreeSharedInstance=1  "share tree instance through all
" tabs
" " use tabnew instead of split for new action
let g:EclimProjectTreeActions = [{'pattern': '.*', 'name': 'Tab', 'action': 'tabnew'}]


" set winaltkeys=no

":map <C-J> :tabprevious<cr>
":map <C-K> :tabnext<cr>
":imap <C-J> <ESC>:tabprevious<cr>i
":imap <C-K> <ESC>:tabnext<cr>i
:map <C-h> :tabprevious<cr>
:map <C-l> :tabnext<cr>
:imap <C-h> <ESC>:tabprevious<cr>i
:imap <C-l> <ESC>:tabnext<cr>i

" Tab Control (others)
":map <C-1> 1gt
":map <C-2> 2gt
":map <C-3> 3gt
":map <C-4> 4gt
":map <C-5> 5gt
":map <C-6> 6gt
":map <C-7> 7gt
":map <C-8> 8gt
":map <C-9> 9gt


set encoding=utf-8

set tags=tags

" jump to start of line
nmap = ^

" The completion dictionary is provided by Rasmus:
" http://lerdorf.com/funclist.txt
set dictionary-=/home/pookey/funclist.txt dictionary+=/home/pookey/funclist.txt
" Use the dictionary completion
set complete-=k complete+=k

" This function determines, wether we are on the start of the line text (then tab indents) or
" if we want to try autocompletion
function InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction

" Delete stuff into black hole register
noremap D "_d

" Block comment

" au FileType haskell,vhdl,ada let b:comment_leader = '-- '
" au FileType vim let b:comment_leader = '" '
" au FileType js,c,cpp,java let b:comment_leader = '// '
" au FileType sh,make let b:comment_leader = '# '
" au FileType tex let b:comment_leader = '% '
" let b:comment_leader = '// '
" noremap <silent> ,c :<C-B>sil <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:noh<CR>
" noremap <silent> ,u :<C-B>sil <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:noh<CR>
noremap <silent> ,c :<C-B>sil <C-E>s/^/<C-R>=escape('// ','\/')<CR>/<CR>:noh<CR>
noremap <silent> ,u :<C-B>sil <C-E>s/^\V<C-R>=escape('// ','\/')<CR>//e<CR>:noh<CR>

" paste from system buffer
" nmap <c-p> "+p<cr>
" map <c-y> "+y<cr>
nnoremap <c-p> :set invpaste paste?<CR>
set pastetoggle=<c-p>
set showmode


" Remap the tab key to select action with InsertTabWrapper
inoremap <tab> <c-r>=InsertTabWrapper()<cr>

" set list
" set listchars=tab:>-,trail:-
" set listchars=tab:>-,trail:-,eol:$
set ignorecase                  " caseinsensitive searches
set showmode                    " always show command or insert mode
set ruler                      " show line and column information
set showmatch                  " show matching brackets
set formatoptions=tcqor
set whichwrap=b,s,<,>,[,]
syntax on

" CTRL-C = SVN Commit
" map <C-C> :w<CR>:!svn commit<CR>

" What is leader?
map <Leader>e :Explore<cr>
map <Leader>s :Sexplore<cr>


" pressing < or > will let you indent/unident selected lines
"
vnoremap < <gv
vnoremap > >gv

" Map <c-s> to write current buffer.

map <c-s> :w<cr>
imap <c-s> <c-o><c-s>
imap <c-s> <esc><c-s>

" I haven't found how to hide this function (yet)
function! RestoreRegister()
  let @" = s:restore_reg
    return ''
endfunction

function! s:Repl()
    let s:restore_reg = @"
    return "p@=RestoreRegister()\<cr>"
endfunction

" NB: this supports "rp that replaces the selection by the contents of @r
" vnoremap <silent> <expr> p <sid>Repl()

let s:putSwap = 1
function TogglePutSwap()
    if s:putSwap
		vnoremap <silent> <expr> p <sid>Repl()
		let s:putSwap = 0
		echo 'noreplace put'
    else
		vnoremap <silent> <expr> p p 
		let s:putSwap = 1
		echo 'replace put'
    endif
	return
endfunction
noremap ,p :call TogglePutSwap()<cr>


function SurroudIf(fl, ll)
	echo 'Iffing'
	let intro = 'if(){\n'
	let outro = '}'
	echo ll
	
	return
endfunction

vmap ,i :call SurroudIf()<cr>


" Eclim code validation
noremap ,s :EclimValidate<cr>


" Automatically open nerdtree
" autocmd vimenter * NERDTree
autocmd vimenter * if !argc() | NERDTree | endif

" Automatically close vim if nerdtree is the only buffer left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'ervandew/supertab'
Plugin 'Valloric/YouCompleteMe'
Plugin 'Shougo/neocomplete'
Plugin 'tpope/vim-fugitive'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'kien/ctrlp.vim'
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'Yggdroot/indentLine'
Plugin 'mileszs/ack.vim'
Plugin 'majutsushi/tagbar'
Plugin 'jiangmiao/auto-pairs'
"Plugin 'klen/python-mode'
Plugin 'pangloss/vim-javascript'
Plugin 'easymotion/vim-easymotion'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-unimpaired'
Plugin 'vim-scripts/vim-auto-save'
Plugin 'tpope/vim-surround'
Plugin 'chriskempson/base16-vim'
Plugin 'claude.vim'
"Plugin 'LaTeX-Box-Team/LaTeX-Box'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Custom settings here
syntax on
set number
set relativenumber
set cmdheight=2
set conceallevel=0
set cursorline

set background=dark
""colorscheme jellybeans
"colorscheme base16-default

"set pastetoggle=<F2>
let mapleader=","
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab

"powerline fonts
let g:airline_powerline_fonts = 1

" vim airline always
set laststatus=2

" highlight when search
set hlsearch

"" Use ctrl-[hjkl] to select the active split!
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

" Neocomplete
 "Disable AutoComplPop.
 let g:acp_enableAtStartup = 0
 " Use neocomplete.
 let g:neocomplete#enable_at_startup = 1
 " Use smartcase.
 let g:neocomplete#enable_smart_case = 1
 " Set minimum syntax keyword length.
 let g:neocomplete#sources#syntax#min_keyword_length = 3
 inoremap <expr><C-n>  neocomplete#start_manual_complete()
 let g:SuperTabDefaultCompletionType = '<C-n>'

 "" better key bindings for UltiSnipsExpandTrigger
 let g:UltiSnipsExpandTrigger = "<tab>"
 let g:UltiSnipsListSnippets = "<c-a>"
 let g:UltiSnipsJumpForwardTrigger = "<tab>"
 let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
 let g:UltiSnipsSnippetsDir = "~/.vim/bundle/vim-snippets/UltiSnips"

 "" Filetype indent
autocmd FileType html setlocal expandtab shiftwidth=2 tabstop=2
autocmd FileType javascript setlocal expandtab shiftwidth=2 softtabstop=2
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4

"" NerdTree
map <C-\> :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\.pyc$']
" close nerdtree with q
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let NERDTreeShowBookmarks=1
let NERDTreeChDirMode=2
highlight Directory ctermfg=cyan

"git fugitive mappings
"
nmap <leader>gs :Gstatus<cr>
nmap <leader>gc :Gcommit<cr>
nmap <leader>gl :Glog<cr>
nmap <leader>gd :Gdiff HEAD<cr>
nmap <leader>gg :Ggrep<cr>
nmap <leader>gb :Gblame<cr>
nmap <leader>gp :Gpush<cr>

"" Breakpoint
map <Leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>


""Linting
let g:pymode_lint = 0
let g:pymode_lint_write = 0
map <C-f> :PymodeLintAuto<CR>

"" syntax highlighting
"let g:pymode_syntax = 1
"let g:pymode_syntax_all = 1
""let g:pymode_lint_on_fly = 1
"let g:pymode_doc = 0
"let g:pymode_folding = 0
"let g:pymode_syntax_indent_errors = g:pymode_syntax_all
"let g:pymode_syntax_space_errors = g:pymode_syntax_all
"let g:pymode_rope_completion = 0
"let g:pymode_rope_rename_bind = '<leader>r'
"let g:pymode_rope_goto_definition_bind = '<leader>g'
"let g:pymode_rope_extract_method_bind = '<leader>rm'

" close scratch automatically
 autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
 autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" syntastic settings
"
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_auto_loc_list = 1
let g:syntastic_loc_list_height=4

"" Ignore some folders and files for CtrlP indexing
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.yardoc\|public$|log\|tmp$',
  \ 'file': '\.so$\|\.dat$|\.DS_Store$'
  \ }
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*.swp,*.zip,*.pyc,*.log,node_modules
let g:ctrlp_working_path_mode = 'r'
let g:ctrlp_max_files=0
let g:ctrlp_max_depth=7
map <C-b> :CtrlPBuffer<CR>
map <C-f> :CtrlPTag<CR>

""latex spell check etc
"let g:tex_conceal = ""
"augroup latexsettings
    "autocmd FileType tex
    "set spell spelllang=en_gb
    ""set textwidth=100
"augroup END

""latexbox
"let g:LatexBox_latexmk_preview_continuously = 1
"let g:LatexBox_quickfix = 1

"easymotion mappings
"let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Bi-directional find motion
" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
"nmap s <Plug>(easymotion-s)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
"nmap s <Plug>(easymotion-s2)

"" Turn on case insensitive feature
"let g:EasyMotion_smartcase = 1

"Auto save
"
let g:auto_save = 1
let g:auto_save_in_insert_mode = 0
let g:auto_save_silent = 1

"ctags
set tags=./tags;/
nmap <Leader>t :TagbarToggle<CR>


execute pathogen#infect()

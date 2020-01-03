syntax on
filetype plugin indent on

set nocompatible
set number
set showmode
set smartcase
set smarttab
set smartindent
set autoindent
set expandtab
set shiftwidth=2
set softtabstop=2
set background=dark
set laststatus=0

" Recursive expansion with :find
set path+=**
" Display all matching files when we tab complete
set wildmenu

" hi Keyword ctermfg=darkcyan
" hi Constant ctermfg=5*
" hi Comment ctermfg=2*
" hi Normal ctermbg=none
" hi LineNr ctermfg=darkgrey

if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
  set termguicolors
endif

" vim-plug plugins
call plug#begin('~/.vim/plugged')

Plug 'kassio/neoterm'

" LSP server integration
" Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': { -> coc#util#install() }}
Plug 'neovimhaskell/haskell-vim'

" Haskell feedback
" Plug 'parsonsmatt/intero-neovim'
Plug 'ndmitchell/ghcid', { 'rtp': 'plugins/nvim' }

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1
Plug 'Shougo/neosnippet.vim'
let g:neosnippet#snippets_directory = 'snips,snippets,neosnippets'
Plug 'Shougo/neosnippet-snippets'
Plug 'honza/vim-snippets'

Plug 'twinside/vim-hoogle'
" Plug 'eagletmt/ghcmod-vim'
Plug 'alx741/vim-stylishask'

Plug 'Shougo/vimproc.vim', {'do' : 'make'}

" General LSP client with support for multiple backends
Plug 'dense-analysis/ale'

" Literate Haskell support
Plug 'wting/lhaskell.vim'

" GoLang support
Plug 'fatih/vim-go'

" Clojure REPL support
Plug 'clojure-emacs/cider-nrepl'
Plug 'tpope/vim-salve'
Plug 'tpope/vim-fireplace'

" Git support
Plug 'tpope/vim-fugitive'
Plug 'shumphrey/fugitive-gitlab.vim' " Adds GBrows support for gitlab
" Plug 'syngan/vim-gitlab' " Adds support for issues/MRs/comments
" Plug 'sirjofri/vim-glissues' " Support for GL issues

" Pandoc support
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'

" Syntastic
" Plug 'scrooloose/syntastic'

" Vue.js support
Plug 'posva/vim-vue'
" Plug 'sekel/vim-vue-syntastic'

" Colour-schemes
Plug 'vim-scripts/summerfruit256.vim' " Light, colourful
Plug 'jnurmine/zenburn'
Plug 'sickill/vim-monokai'
Plug 'junegunn/seoul256.vim' 
Plug 'rakr/vim-one' " Light and dark, muted
Plug 'flazz/vim-colorschemes' " one pack of lots of schemes
Plug 'nlknguyen/papercolor-theme'
Plug 'iCyMind/NeoSolarized'
Plug 'lifepillar/vim-solarized8'

" UI
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'junegunn/fzf'
Plug 'majutsushi/tagbar'

" Integrations
Plug 'raghur/vim-ghost', {'do': ':GhostInstall'}
Plug 'thoughtbot/vim-rspec'

call plug#end()

" Allow project specific .nvimrc files
" see: https://andrew.stwrt.ca/posts/project-specific-vimrc/
set exrc
" Prevent shelling out in project specific Configuration files.
set secure 

" Sets bash environment when using the shell
" let $BASH_ENV = "$HOME/.config/bash/bash-in-vim.rc"

imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" Snippet options
au FileType neosnippet setl noexpandtab

" au BufNewFile,BufReadPost *.md setl syntax=markdown
au FileType markdown setl ts=4 sw=4 cc=100 tw=80
au FileType pandoc setl ts=4 sw=4 cc=100 tw=80

"" NERDTree configure

"Open NERDTree when nvim starts
autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" NERDTree bindings
" mnemonic: nerd
map <C-n> :NERDTreeToggle<CR><C-w>p
" mnemonic: here
map <C-h> :NERDTreeFind<CR>

" Load other config files
" runtime coc_config.vim
runtime ale_config.vim
" runtime syntastic_config.vim
" runtime ghcmod_config.vim
" runtime neco_config.vim
runtime golang.vim

"Show hidden files in NERDTree
let NERDTreeShowHidden=1

" Use spaces around comment characters, and strip them
let NERDSpaceDelims=1
let NERDRemoveExtraSpaces=1

"Haskell Mode settings
let g:haskell_classic_highlighting = 1
let g:haskell_indent_if = 3
let g:haskell_indent_case = 2
let g:haskell_indent_let = 4
let g:haskell_indent_where = 6
let g:haskell_indent_before_where = 2
let g:haskell_indent_after_bare_where = 2
let g:haskell_indent_do = 3
let g:haskell_indent_in = 1
let g:haskell_indent_guard = 2
let g:haskell_indent_case_alternative = 1
let g:cabal_indent_section = 2

" To use `ALT+{h,j,k,l}` to navigate windows from any mode:
tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l
inoremap <A-h> <C-\><C-N><C-w>h
inoremap <A-j> <C-\><C-N><C-w>j
inoremap <A-k> <C-\><C-N><C-w>k
inoremap <A-l> <C-\><C-N><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
"ESC leaves terminal mode
tnoremap <Esc> <C-\><C-n>
let g:neoterm_autoscroll = '1'

" augroup interomaps
"   au!
"   "Intero Configuration
"   " Automatically reload on save
"   au BufWritePost *.hs InteroReload

"   " Lookup the type of expression under the cursor
"   au FileType haskell nmap <silent> <leader>t <Plug>InteroGenericType
"   au FileType haskell nmap <silent> <leader>T <Plug>InteroType

"   " Insert type declaration
"   au FileType haskell nnoremap <silent> <leader>ni :InteroTypeInsert<CR>
"   " Show info about expression or type under the cursor
"   au FileType haskell nnoremap <silent> <leader>i :InteroInfo<CR>

"   " Open/Close the Intero terminal window
"   au FileType haskell nnoremap <silent> <leader>nn :InteroOpen<CR>
"   au FileType haskell nnoremap <silent> <leader>nh :InteroHide<CR>

"   " Reload the current file into REPL
"   au FileType haskell nnoremap <silent> <leader>nf :InteroLoadCurrentFile<CR>
"   " Jump to the definition of an identifier
"   au FileType haskell nnoremap <silent> <leader>ng :InteroGoToDef<CR>
"   " Evaluate an expression in REPL
"   au FileType haskell nnoremap <silent> <leader>ne :InteroEval<CR>

"   " Start/Stop Intero
"   au FileType haskell nnoremap <silent> <leader>ns :InteroStart<CR>
"   au FileType haskell nnoremap <silent> <leader>nk :InteroKill<CR>

"   " Reboot Intero, for when dependencies are added
"   au FileType haskell nnoremap <silent> <leader>nr :InteroKill<CR> :InteroOpen<CR>

"   " Managing targets
"   " Prompts you to enter targets (no silent):
"   au FileType haskell nnoremap <leader>nt :InteroSetTargets<CR>

"   " Run the spec in the current file
"   au FileType haskell nnoremap <silent> <leader>nb :InteroSend hspec spec<CR>
" augroup END

" Haskell code formatting
let g:stylishask_on_save = 0
au FileType haskell nnoremap <silent> <leader>ps :Stylishask<CR>

au FileType haskell nnoremap <silent> <leader>hl :GhcModLint<CR>

" Terminal settings
au TermOpen * setlocal nonumber norelativenumber

" Custom IRB console at the bottom of the screen
" Same keybindings as Intero, nn/nh
command OpenIRB execute ":botright T irb"
command OpenRailsC execute ":botright T railsc"
command MigrateTest execute ":T rails db:migrate RAILS_ENV=test"
command MigrateRails execute ":T rails db:migrate"
command UpstreamChanges execute ":T bundt-deps" | execute ":MigrateTest" | execute ":MigrateRails"

" Execute line under cursor as vim-script command (useful when editing this
" file)
nnoremap <leader>so Y:@"<CR>

au FileType ruby nnoremap <silent> <leader>nn :OpenIRB<CR>
au FileType ruby nnoremap <silent> <leader>nr :OpenRailsC<CR>
au FileType ruby nnoremap <silent> <leader>nh :Tclose<CR>
" RSpec.vim mappings
au FileType ruby map <Leader>t :call RunCurrentSpecFile()<CR>
au FileType ruby map <Leader>s :call RunNearestSpec()<CR>
au FileType ruby map <Leader>l :call RunLastSpec()<CR>
au FileType ruby map <Leader>a :call RunAllSpecs()<CR>
au FileType ruby setl ts=2 sw=2 cc=100 tw=80

" Tags
au FileType ruby command! MakeTags execute "!ctags -R --languages=ruby --exclude=.git --exclude=db/migrate --exclude=node_modules --exclude=qa --exclude=doc --exclude=log ."
au FileType go command! MakeTags execute "!ctags -R --languages=golang --exclude=.git --exclude=docs --exclude=log ."

" Send command to next pane
let g:rspec_command = "T glspec {spec}"

" UltiSnips - default values:
"let g:UltiSnipsExpandTrigger               <tab>
"let g:UltiSnipsListSnippets                <c-tab>
"let g:UltiSnipsJumpForwardTrigger          <c-j>
"let g:UltiSnipsJumpBackwardTrigger         <c-k>

function! VisualSelection()
  try
    let a_save = @a
    normal! gv"ay
    return @a
  finally
    let @a = a_save
  endtry
endfunction

function! ReplSend(...) range
  let code = VisualSelection()
  let expr = ""
  if a:0 == 1
    " Need some instruction on how to get this working...
    " " 'v' gets the start of the selection (or cursor pos if no selection)
    " let [l:l1, l:c1] = getpos('v')[1:2]
    " " " '.' gets the cursor pos (or the end of the selection if selection)
    " let [l:l2, l:c2] = getpos('.')[1:2]

    " let hs_type = intero#repl#type_at(0, l:l1, l:c1, l:l2, l:c2)
    " let expr .= "let " . a:1 . " :: " . hs_type
    " let expr .= "\n"
    if &filetype ==# 'haskell' || &filetype ==# 'javascript'
      let expr .= "let " . a:1 . " = "
    elseif &filetype ==# 'ruby' || &filetype ==# 'python'
      let expr .= a:1 . " = "
    endif
  endif
  let expr .= code

  call ReplSendExpr(expr)
endfunction

function! ReplSendLine(...) range
  let code = join(getline(a:firstline,a:lastline), "\n")
  let expr = ""
  if a:0 == 1
    let expr .= "let "
    if a:1 != "let"
      let expr .= a:1 . " = "
    endif
  endif
  let expr .= code

  call ReplSendExpr(expr)
endfunction

function! ReplSendExpr(expr)
  if &filetype ==# 'haskell'
    execute 'InteroSend' ":{"
    let l:i = 0
    for frag in split(a:expr, "\n")
      if l:i > 0
        let frag = "    " . frag
      endif
      call intero#repl#send(frag)
      let l:i += 1
    endfor
    execute 'InteroSend' ":}"
  else
    execute ('T ' . a:expr)
  end
endfunction

command -range -nargs=? SendRepl call ReplSend(<f-args>)
command -range -nargs=? SendReplLine <line1>,<line2>call ReplSendLine(<f-args>)
command -range -nargs=0 SendReplCAF <line1>,<line2>call ReplSendLine("let")

" relative path  (src/foo.txt)
nnoremap <leader>cf :let @+=expand("%")<CR>

" absolute path  (/something/src/foo.txt)
nnoremap <leader>cF :let @+=expand("%:p")<CR>

" filename       (foo.txt)
nnoremap <leader>ct :let @+=expand("%:t")<CR>

" directory name (/something/src)
nnoremap <leader>ch :let @+=expand("%:p:h")<CR>

au FileType pandoc execute ':PandocHighlight haskell'

" Vue.js support
autocmd FileType vue syntax sync fromstart

" Git configuration
au FileType gitcommit setlocal tw=72 colorcolumn=72

let g:gitlab_api_keys = {'gitlab.com': $GITLAB_FUGITIVE_TOKEN}

" let g:gitlab_config['gitlab'] ={
"      \    'url' : 'https://gitlab.com/',
"      \    'user' : 'alexkalderimis',
"      \    'email' : 'akalderimis@gitlab.com'
"      \}

" PaperColor

let g:PaperColor_Theme_Options = {
  \   'theme': {
  \     'default': {
  \       'override': {
  \         'linenumber_bg' : ['#888888', '232'],
  \         'cursorlinenr_bg' : ['#f59842', ''],
  \         'cursorlinenr_fg' : ['#fae1ca', '']
  \       }
  \     }
  \   }
  \ }

" Airline

let g:airline#extensions#tabline#enabled = 1
" let g:airline_theme='base16_spacemacs'
let g:airline_theme='papercolor'

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.dirty='⚡'

" CTRLP
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_working_path_mode='ra'
let g:ctrlp_cmd = 'CtrlPMixed'

" Use fuzzy-find
nnoremap <C-p> :FZF<CR>

" Neoterm:
let g:neoterm_default_mod = ':vertical :botright'

" Color schemes:
"

set background=light
colorscheme one

if $TERM_VARIANT == 'dark'
  set background=dark
  colorscheme one
endif
if $TERM_VARIANT == 'light'
  set background=light
  colorscheme one
endif

" DARK THEMES
" colorscheme solarized8
" colorscheme monokai
" colorscheme molokai
" colorscheme dracula

" LIGHT THEMES
" set background=light
" colorscheme one
" colorscheme NeoSolarized
" colorscheme PaperColor
" colorscheme summerfruit256


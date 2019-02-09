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

" Allow project specific .nvimrc files
" see: https://andrew.stwrt.ca/posts/project-specific-vimrc/
set exrc
" Prevent shelling out in project specific Configuration files.
set secure 

" hi Keyword ctermfg=darkcyan
" hi Constant ctermfg=5*
" hi Comment ctermfg=2*
" hi Normal ctermbg=none
" hi LineNr ctermfg=darkgrey

" vim-plug plugins
call plug#begin('~/.vim/plugged')

Plug 'parsonsmatt/intero-neovim'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1
Plug 'Shougo/neosnippet.vim'
let g:neosnippet#snippets_directory = 'snips,snippets'
Plug 'Shougo/neosnippet-snippets'
Plug 'junegunn/seoul256.vim'

Plug 'neomake/neomake'

call plug#end()

imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" Pathogen - deprecated
execute pathogen#infect()

set background=dark
colorscheme solarized8

" au BufNewFile,BufReadPost *.md setl syntax=markdown
au FileType markdown setl ts=4 sw=4 cc=100 tw=80

"" NERDTree configure

"Open NERDTree when nvim starts
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"Toggle NERDTree with Ctrl-N
map <C-n> :NERDTreeToggle<CR>

"Show hidden files in NERDTree
let NERDTreeShowHidden=1

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

"Ctrl-{hjkl} for navigating out of terminal panes
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l

"Intero Configuration
" Automatically reload on save
au BufWritePost *.hs InteroReload

" Lookup the type of expression under the cursor
au FileType haskell nmap <silent> <leader>t <Plug>InteroGenericType
au FileType haskell nmap <silent> <leader>T <Plug>InteroType

" Insert type declaration
au FileType haskell nnoremap <silent> <leader>ni :InteroTypeInsert<CR>
" Show info about expression or type under the cursor
au FileType haskell nnoremap <silent> <leader>i :InteroInfo<CR>

" Open/Close the Intero terminal window
au FileType haskell nnoremap <silent> <leader>nn :InteroOpen<CR>
au FileType haskell nnoremap <silent> <leader>nh :InteroHide<CR>

" Reload the current file into REPL
au FileType haskell nnoremap <silent> <leader>nf :InteroLoadCurrentFile<CR>
" Jump to the definition of an identifier
au FileType haskell nnoremap <silent> <leader>ng :InteroGoToDef<CR>
" Evaluate an expression in REPL
au FileType haskell nnoremap <silent> <leader>ne :InteroEval<CR>

" Start/Stop Intero
au FileType haskell nnoremap <silent> <leader>ns :InteroStart<CR>
au FileType haskell nnoremap <silent> <leader>nk :InteroKill<CR>

" Reboot Intero, for when dependencies are added
au FileType haskell nnoremap <silent> <leader>nr :InteroKill<CR> :InteroOpen<CR>

" Managing targets
" Prompts you to enter targets (no silent):
au FileType haskell nnoremap <leader>nt :InteroSetTargets<CR>

" Run the spec in the current file
au FileType haskell nnoremap <silent> <leader>nb :InteroSend hspec spec<CR>

call neomake#configure#automake('w')
let g:neomake_open_list = 2
" Only run checks on save
let g:neomake_haskell_enabled_makers = [] 

" Better Haskell Completions

" Disable haskell-vim omnifunc
let g:haskellmode_completion_ghc = 0

" neco-ghc
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc 
let g:necoghc_enable_detailed_browse = 1

" Haskell code formatting
let g:hindent_on_save = 0
au FileType haskell nnoremap <silent> <leader>ph :Hindent<CR>

let g:stylishask_on_save = 0
au FileType haskell nnoremap <silent> <leader>ps :Stylishask<CR>

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

function! ReplSend(...)
  let code = VisualSelection()
  let expr = ""
  if a:0 == 1
    let expr .= "let " . a:1 . " = "
  endif
  let expr .= code

  execute 'InteroSend' ":{"
  for frag in split(expr, "\n")
    call intero#repl#send(frag)
  endfor
  execute 'InteroSend' ":}"
endfunction

function! ReplSendLine(...)
  let code = join(getline(a:firstline,a:lastline), "\n")
  let expr = ""
  if a:0 == 1
    let expr .= "let " . a:1 . " = "
  endif
  let expr .= code

  execute 'InteroSend' ":{"
  for frag in split(expr, "\n")
    call intero#repl#send(frag)
  endfor
  execute 'InteroSend' ":}"
endfunction

command -range -nargs=? SendRepl call ReplSend(<f-args>)
command -range -nargs=? SendReplLine <line1>,<line2>call ReplSendLine(<f-args>)

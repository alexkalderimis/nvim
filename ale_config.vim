" ALE Configuration
let g:ale_linters_explicit = 1
let g:ale_fix_on_save = 1
let g:ale_linters ={
      \   'haskell': ['hlint'],
      \   'go': ['gofmt', 'golint', 'gopls'],
      \   'ruby': ['ruby', 'rubocop']
      \}
let g:ale_fixers = {
      \   'javascript': ['prettier'],
      \   'css': ['prettier'],
      \   'vue': ['prettier'],
      \   'go': ['gofmt'],
      \   'haskell': ['brittany', 'hlint']
      \}

command ShowHint call ale#cursor#ShowCursorDetail()

nnoremap <leader>t :ALEHover<CR>

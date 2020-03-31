set nocompatible

" ALE
let g:ale_sign_error                  = '✘'
let g:ale_sign_warning                = '⚠'
highlight ALEErrorSign ctermbg        =NONE ctermfg=red
highlight ALEWarningSign ctermbg      =NONE ctermfg=yellow
let g:ale_linters_explicit            = 1
let g:ale_lint_on_text_changed        = 'never'
let g:ale_lint_on_enter               = 0
let g:ale_lint_on_save                = 1
let g:ale_fix_on_save                 = 1

let g:ale_linters = {
\   'markdown':      ['writegood', 'proselint', 'markdownlint'],
\   'javascript':      ['eslint', 'flow', 'flow-language-server'],
\   'sql':      ['sqlint'],
\   'dart': ['language_server'],
\}

let g:ale_fixers = {
\   '*':          ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['prettier'],
\   'typescript': ['tslint', 'prettier'],
\   'css': ['prettier'],
\   'dart': ['dartfmt'],
\}

" disables ale for go files
let g:ale_pattern_options = {
\   '.*\.go$': {'ale_enabled': 0},
\}

" Enables syntax highlighting.
syntax on
filetype plugin indent on
execute pathogen#infect()

" Number of lines to scroll with CTRL-U and CTRL-D commands.
set scroll=3
" Sets word wrapping at words, not letters.
"set linebreak
set smartcase
" Disables word wrapping.
set nowrap
" Enables https://github.com/lifepillar/pgsql.vim on .sql files
let g:sql_type_default = 'pgsql'
" Sets theme and font
color gruvbox
set background=dark
set guifont=Inconsolata\ Bold\ 13.5
" Avoids cropping of last line.
set display+=lastline
"set tab as default indent equivalent to 4 spaces
set tabstop=4 softtabstop=0 noexpandtab shiftwidth=4
" Hides Vim menu.
set guioptions -=T
set guioptions -=m
set guioptions -=r
" Displays line numbers.
set number

" change the <leader> from \ to ,
let mapleader=","

" Hit ]s and you will be transported to the next misspelled word.
" Hit zg to ignore mispelled word and zG to ignore all.
nnoremap <leader>en :setlocal spell spelllang=en_us<CR>
nnoremap <leader>es :setlocal spell spelllang=es_cl<CR>

" g] lists all tags, <Ctrl>] goes to tag
" :tn goes to next tag, :tp, to previous one.
"let o=system("ctags --recurse --exclude=ui --exclude=node_modules --exclude=.git --exclude=typings --exclude=*_test.go --exclude=*.spec.* --exclude=*_mock.go")
set tags=./tags
" Creates a tag file by searching recursively.
nnoremap <leader>ct :!ctags --recurse --exclude=ui --exclude=node_modules --exclude=.git --exclude=typings --exclude=*_test.go --exclude=*.spec.* --exclude=*_mock.go<CR>
" The leading `./` tells Vim to use the directory
" of the current file  rather than the CWD.
" The `;` tells Vim to search in the parent
" folders until / is reached
nnoremap <leader>t :set tags=./tags;<CR>

"Highlight TOML front matter as used by Hugo.
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_strikethrough = 1
let g:vim_markdown_folding_disabled = 1
set scroll=3

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

autocmd FileType * setlocal scroll=3
" Align GitHub-flavored Markdown tables
autocmd FileType markdown vmap <Leader><Bar> :EasyAlign*<Bar><Enter>
" Sets default formatter for SQL
autocmd FileType sql setlocal formatprg=/usr/local/bin/pg_format\ --keyword-case=0\ --wrap-limit\ 30\ --tabs\ -
autocmd Filetype yml setlocal tabstop=2
autocmd Filetype yml setlocal shiftwidth=2
autocmd Filetype yml setlocal expandtab
autocmd FileType javascript nmap <C-]> :ALEGoToDefinition<CR>
autocmd FileType javascript setlocal suffixesadd=.js,.jsx
autocmd FileType *.jsx setlocal suffixesadd=.js,.jsx
autocmd FileType go setlocal suffixesadd=.go
autocmd FileType typescript nmap <C-]> :ALEGoToDefinition<CR>
autocmd FileType go nmap <C-]> :GoDef<CR>
" Go to referrers
autocmd FileType javascript nnoremap <C-[> :ALEFindReferences<CR>
autocmd FileType typescript nnoremap <C-[> :ALEFindReferences<CR>
autocmd FileType go nnoremap <C-[> :GoReferrers<CR>
" Modify the file after writing the buffer to disk
" spaces are escaped
autocmd BufWritePost *.sql silent ! /usr/local/bin/pg_format\ %:p\ --tabs -o\ %:p\ 2>/dev/null<CR>
" Suffixes for `gf`
autocmd FileType javascript setlocal suffixesadd=.js,.jsx
autocmd FileType go setlocal suffixesadd=.go
"break lines at words, not letters.
autocmd FileType txt setlocal linebreak
autocmd BufRead,BufNewFile *.md setlocal textwidth=80
autocmd Filetype gitcommit setlocal spell textwidth=54
" Number of lines to scroll with CTRL-U and CTRL-D commands.
setlocal scroll=3
autocmd VimEnter,BufRead,BufNewFile,BufWritePre,BufWritePost * setlocal scroll=3
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>
autocmd BufRead,BufNewFile,BufWritePre *.md setlocal textwidth=70
autocmd Filetype gitcommit setlocal spell textwidth=54


" SQL Linter (I deleted this linter so...)
"let g:sqlfmt_command = "sqlformat"
"let g:sqlfmt_options = "-r -k upper"

" this fixes unexpected behavior from backspace
set backspace=indent,eol,start

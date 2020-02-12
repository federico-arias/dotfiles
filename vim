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
\   'javascript':      ['eslint', 'tsserver', 'flow'],
\}

let g:ale_fixers = {
\   '*':          ['remove_trailing_lines', 'trim_whitespace'],
\}

" disables ale for go files
let g:ale_pattern_options = {
\   '.*\.go$': {'ale_enabled': 0},
\}

" Enables syntax highlighting.
syntax on
filetype plugin indent on
execute pathogen#infect()

" Sets word wrapping at words, not letters.
"set linebreak
set ignorecase
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

" change the mapleader from \ to ,
let mapleader=","

" Hit ]s and you will be transported to the next misspelled word.
" Hit zg to ignore mispelled word and zG to ignore all.
nnoremap <leader>en :setlocal spell spelllang=en_us<CR>
nnoremap <leader>es :setlocal spell spelllang=es_cl<CR>


"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
" Sets Syntastic to active mode (checks are made on save or open) but not
" for, in this case, Go files, which will be checked only when explicitly
" running :SyntasticCheck
"let g:syntastic_mode_map = {
"    \ "mode": "active",
"    \ "passive_filetypes": ["go"] }

"let g:syntastic_markdown_checkers = ['proselint']

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
"let g:table_mode_corner='+'
"let g:table_mode_corner_corner='|'
"let g:table_mode_header_fillchar='-'
let g:vim_markdown_override_foldtext = 0

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"vmap <Leader><Bslash> :EasyAlign*<Bar><Enter>

" Align GitHub-flavored Markdown tables
au FileType markdown vmap <Leader><Bar> :EasyAlign*<Bar><Enter>
" Sets default formatter for SQL
autocmd FileType sql setl formatprg=/usr/local/bin/pg_format\ -
autocmd Filetype yml setlocal tabstop=2
autocmd Filetype yml setlocal shiftwidth=2
autocmd Filetype yml setlocal expandtab
" Modify the file after writing the buffer to disk
" spaces are escaped
autocmd BufWritePost *.sql silent ! /usr/local/bin/pg_format\ %:p\ -o\ %:p\ 2>/dev/null<CR>

" SQL Linter (I deleted this linter so...)
"let g:sqlfmt_command = "sqlformat"
"let g:sqlfmt_options = "-r -k upper"
set backspace=indent,eol,start

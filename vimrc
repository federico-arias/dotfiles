set nocompatible

" set the runtime path (rtp) to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'leafgarland/typescript-vim'
Plugin 'peitalin/vim-jsx-typescript'


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
\   'typescript':      ['tsserver', 'tslint'],
\   'sql':      ['sqlint'],
\   'dart': ['language_server'],
\   'yaml': ['yamllint'],
\   'python': ['flake8'],
\}

let g:ale_fixers = {
\   '*':          ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['prettier'],
\   'typescript': ['tslint', 'prettier'],
\   'css': ['prettier'],
\   'dart': ['dartfmt'],
\   'python': ['black'],
\}

" disables ale for Go files
let g:ale_pattern_options = {
\   '.*\.go$': {'ale_enabled': 0},
\}

" Enables syntax highlighting.
syntax on
filetype plugin indent on
execute pathogen#infect()

" :set\ paste<CR> "+p :set nopaste

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
set tabstop=4
set softtabstop=0
"do not convert (expand) spaces to tabs
set noexpandtab
"expand 4 characters when indenting with >>
set shiftwidth=4
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
nnoremap <leader>, :cd %:h<CR>

nnoremap "+p :set paste<CR>i<C-R><C-R>+<C-O>:set nopaste<CR>
" g] lists all tags, <Ctrl>] goes to tag
" :tn goes to next tag, :tp, to previous one.
"let o=system("ctags --recurse --exclude=ui --exclude=node_modules --exclude=.git --exclude=typings --exclude=*_test.go --exclude=*.spec.* --exclude=*_mock.go")
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

:nnoremap <S-Space> :cp<CR>
:nnoremap <Space> :cn<CR>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" set filetypes as typescript.tsx
autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx
" Align GitHub-flavored Markdown tables
autocmd FileType markdown vmap <Leader><Bar> :EasyAlign*<Bar><Enter>
" Sets default formatter for SQL
autocmd FileType sql setlocal formatprg=/usr/local/bin/pg_format\ --keyword-case=0\ --wrap-limit\ 30\ --tabs\ -
" Replace tabs for spaces in certain file types
autocmd FileType coffee setlocal tabstop=2 shiftwidth=2 expandtab
autocmd FileType yaml,yml setlocal tabstop=2 shiftwidth=2 expandtab
" Navigate to file
autocmd FileType javascript setlocal suffixesadd=.js,.jsx
autocmd FileType javascriptreact setlocal suffixesadd=.js,.jsx
autocmd FileType typescript,typescript.tsx setlocal suffixesadd=.ts,.tsx
autocmd FileType go setlocal suffixesadd=.go
" Go to definitions
autocmd FileType typescript nmap <C-]> :ALEGoToDefinition<CR>
autocmd FileType javascript,javascriptreact nmap <C-]> :ALEGoToDefinition<CR>
autocmd FileType go nmap <C-]> :GoDef<CR>
" Go to referrers
autocmd FileType javascript,javascriptreact,typescript nnoremap <Leader><Leader> :ALEFindReferences<CR>
autocmd FileType go nnoremap <Leader><Leader> :GoReferrers<CR>
" format sql with sqlfmt
autocmd Filetype sql set formatprg=/home/federico/.local/bin/sqlfmt\
" Modify the file before writing the buffer to disk
"autocmd BufWritePre *.sql :execute "normal ggVGgq"
"
"break lines at words, not letters.
autocmd FileType txt setlocal linebreak
autocmd BufRead,BufNewFile *.md setlocal textwidth=80
autocmd Filetype gitcommit setlocal spell textwidth=54
autocmd BufRead,BufNewFile,BufWritePre *.md setlocal textwidth=70
autocmd Filetype gitcommit setlocal spell textwidth=54
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" this fixes unexpected behavior from backspace
set backspace=indent,eol,start

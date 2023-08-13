set nocompatible
filetype plugin on
syntax on

" wondering where an unexpected option or marker was set? check ':verbose set
"
" textwidth?' as an example.

" Basic Options ---------------------------- {{{
""" to get more information about these options,
""" type :help '<option>' where <option> is a
""" set option.
set guifont=Droid\ Sans\ Mono\ for\ Powerline\ 12"
set t_vb= " Disable beeping
set t_Co=256 " Support 256 colors
set encoding=utf-8
set expandtab
set clipboard+=unnamedplus
set list
set mouse=a
set listchars=trail:¬,tab:▸\ 
set cursorline
set hlsearch
set backupcopy=yes
set wildmenu
set ignorecase
set smartcase
set shortmess+=I
set relativenumber
set number
set splitright
set foldlevelstart=99
set splitbelow
set smartindent
set cinoptions=g0(0:0
set softtabstop=4
set tabstop=4
set shiftwidth=4
set wrap
set notimeout
set ttimeout
set ttimeoutlen=10
set autoread
set hidden
" always display the statusline in all windows
set laststatus=2
" hide the default mode text (e.g. -- INSERT -- below the statusline)
set noshowmode
let mapleader = ","
let maplocalleader = "\\"
" }}}
" Plugins ---------------------------- {{{
"   Init ---------------------------- {{{
call plug#begin('~/.vim/plugged')

Plug 'christoomey/vim-tmux-navigator'
Plug 'chriskempson/base16-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'

Plug 'w0rp/ale'
Plug 'machakann/vim-highlightedyank'
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'

" Additional Text Objects
Plug 'vim-scripts/argtextobj.vim' " ia, aa (function argument parameters)

Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

" Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'wellle/tmux-complete.vim'

" tmux-complete
let g:tmuxcomplete#asyncomplete_source_options = {
            \ 'name':      'tmuxcomplete',
            \ 'config': {
            \     'splitmode':      'ilines,words'
            \     }
            \ }

Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'cespare/vim-toml'
Plug 'benmills/vimux'

Plug 'hashivim/vim-terraform'

call plug#end()
"   }}}
" Plugin: vim-easy-align --------------------------- {{{
xmap <Enter> <Plug>(EasyAlign)
"   }}}
" Plugin: Airline --------------------- {{{
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='deus'
" }}}
" Plugin: JSON ------------------------ {{{
let g:vim_json_syntax_conceal = 0
" }}}
" Plugin: Pymode  ------------------------ {{{
let g:pymode_indent = 1
let g:pymode_rope = 0
let g:pymode_lint_write = 0
" }}}
" Plugin: Tagbar  ------------------------ {{{
nmap <silent> <f5> :TagbarToggle<cr>
" }}}
" Plugin: Typescript  ------------------------ {{{
let g:typescript_compiler_options = '--jsx react'
" }}}
" Plugin: Move  ------------------------ {{{
" let g:move_key_modifier = ''
" }}}
" Plugin: Javascript  ------------------------ {{{
" }}}
" }}}
" General Mappings ---------------------- {{{
" disable f1 opening help pages
inoremap <F1> <nop>

" disable going into ex mode by accident
nnoremap Q <nop>

" unjoin at cursor
" nnoremap K i<cr><esc>k:s/\s\+$//<cr>j

" j and k within a wrap
noremap j gj
noremap k gk
noremap gj j
noremap gk k

" easier buffer navigation
noremap <c-h> <c-w>h
noremap <c-j> <c-w>j
noremap <c-k> <c-w>k
noremap <c-l> <c-w>l

" easier buffer sizing
noremap <s-left> :vertical resize -5<cr>
noremap <s-right> :vertical resize +5<cr>
noremap <s-down> :resize -5<cr>
noremap <s-up> :resize +5<cr>

" easier buffer switching
nnoremap <tab> :bn<cr>
nnoremap <s-tab> :bp<cr>

nnoremap <leader>f <c-i>
nnoremap <leader>b <c-o>

" Keep search matches in the middle of the window and open fold
nnoremap n nzzzv
nnoremap N Nzzzv

" removes all windows except (t)his (w)indow
nnoremap <leader>tw :on<cr>

" toggle search highlighting
nnoremap <leader>hs :set hlsearch!<cr>

" source current line and selection
vnoremap <leader>S y:execute @@<cr>:echo 'Sourced selection.'<cr>
nnoremap <leader>S ^yg_y:execute @@<cr>:echo 'Sourced line.'<cr>

" save file using sudo
cnoremap w!! w !sudo tee % > /dev/null

" clean trailing whitespace
" nnoremap <leader>ww mz:%s/\s\+$//<cr>:let @/=''<cr>`z

" shortcuts for opening splits of files
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>ef :execute ":vsplit " . $HOME . "/.config/nvim/ftplugin/" . split(&filetype, '\.')[-1] . ".vim"<cr>
nnoremap <leader>es :execute ":vsplit " . $HOME . "/.zshrc"<cr>
" }}}
" Functions ---------------------- {{{
"   List Toggles ---------------------- {{{
function! GetBufferList()
  redir =>buflist
  silent! ls
  redir END
  return buflist
endfunction

function! ToggleList(bufname, pfx)
  let buflist = GetBufferList()
  for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if bufwinnr(bufnum) != -1
      exec(a:pfx.'close')
      return
    endif
  endfor
  if a:pfx == 'l'
      exec "Errors"
      if len(getloclist(0)) == 0
          echohl ErrorMsg
          echo "Location List is Empty."
          return
      endif
  endif
  let winnr = winnr()
  exec(a:pfx.'open')
  if winnr() != winnr
    wincmd p
  endif
endfunction

nmap <silent> <f3> :call ToggleList("Location List", 'l')<cr>
nmap <silent> <f4> :call ToggleList("Quickfix List", 'c')<cr>
" }}}
" }}}
" Autocmds ---------------------- {{{
augroup trailing
    au!
    au InsertEnter * :set listchars-=trail:¬
    au InsertLeave * :set listchars+=trail:¬
augroup END

" resize splits when window is resized
augroup window_resize
    au!
    au VimResized * :wincmd =
augroup END
" }}}
" Colors ---------------------------- {{{
" set background=dark
" if filereadable(expand("~/.vimrc_background"))
"   let base16colorspace=256
"   set termguicolors
"   source ~/.vimrc_background
" endif
" hi Normal ctermbg=none


if exists('$BASE16_THEME')
      \ && (!exists('g:colors_name') || g:colors_name != 'base16-$BASE16_THEME')
    let base16colorspace=256
    colorscheme base16-$BASE16_THEME
endif



hi clear CursorLine
hi CursorLineNR cterm=bold gui=bold ctermfg=10 guifg=#A1B56C
augroup cusorline_color
    au!
    au ColorScheme * hi clear CursorLine
    au ColorScheme * hi CursorLineNR cterm=bold gui=bold ctermfg=10 guifg=#A1B56C
augroup END
" }}}



if executable('rg')
    set grepprg=rg\ --no-heading\ --vimgrep
    set grepformat=%f:%l:%c:%m
endif

noremap <leader>s :Rg
let g:fzf_layout = { 'down': '~30%' }
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \ <bang>0)

" Open hotkeys
map <C-p> :Files<CR>
nmap <leader>; :Buffers<CR>

" Files command with preview window
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" <leader><leader> toggles between buffers
nnoremap <leader><leader> <c-^>

" <leader>= reformats current tange
nnoremap <leader>= :'<,'>RustFmtRange<cr>

" <leader>q shows stats
nnoremap <leader>q g<c-g>

" M to make
noremap M :!make -k -j4<cr>

" Open new file adjacent to current file
nnoremap <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Linter
let g:ale_sign_column_always = 1
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'
" only lint on save
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_save = 0
let g:ale_lint_on_enter = 0

noremap <C-q> :confirm qall<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" language server protocol
let g:LanguageClient_settingsPath = "/home/mack/.config/nvim/settings.json"
let g:LanguageClient_serverCommands = {
            \ 'rust': ['rls'],
            \ 'python': ['pyls'],
            \ }
let g:LanguageClient_autoStart = 1
nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>

" CoC Completion
" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" Set tab complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
" Don't hijack enter key
inoremap <expr><CR> (pumvisible()?(empty(v:completed_item)?"\<CR>\<CR>":"\<CR>"):"\<CR>")

"""""""""""""""""""""""""""""""""""""""""""""""""""""

" Quick-save
nmap <leader>w :w<CR>

set tags=.git/tags

" nmap <silent> L <Plug>(ale_lint)
nmap <silent> L <Plug>(ale_lint)

if has('nvim')
    runtime! plugin/python_setup.vim
endif

xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

function! ExecuteMacroOverVisualRange()
    echo "@".getcmdline()
    execute ":'<,'>normal @".nr2char(getchar())
endfunction


"" CoC Extensions
" :CocInstall coc-rust-analyzer - https://github.com/fannheyward/coc-rust-analyzer
" :CocInstall coc-json

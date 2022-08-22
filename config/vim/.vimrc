""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 基本設定
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set fenc=utf-8             "文字コードをUFT-8に設定"
set nobackup               "バックアップファイルを作らない"
set noswapfile             "スワップファイルを作らない"
set autoread               "編集中のファイルが変更されたら自動で読み直す"
set hidden                 "バッファが編集中でもその他のファイルを開けるように"
set showcmd                "入力中のコマンドをステータスに表示する"
set showmode               "現在のモードを表示する"
set pumheight=10           "補完メニューの高さを設定"
set ruler                  "ルーラーを表示"
set number                 "行番号を表示"
set cursorline             "現在の行を強調表示"
set showmatch              "括弧入力時の対応する括弧を表示"
set laststatus=2           "ステータスラインを常に表示"
set wrap                   "ウィンドウの幅より長い行は折り返して、次の行に続けて表示する"
set wildmode=list:longest  "コマンドラインの補完"
set virtualedit=block      "vim の矩形選択で文字が無くても右へ進める"
set virtualedit=onemore    "行末の1文字先までカーソルを移動できるように"
set cursorcolumn

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tab系
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set list listchars=tab:\▸\-  "不可視文字を可視化(タブが「▸-」と表示される)"
set expandtab                "Tab文字を半角スペースにする"
set tabstop=2                "インデントをスペース2つ分に設定"
set tabstop=2                "行頭以外のTab文字の表示幅（スペースいくつ分）"
set shiftwidth=2             "行頭でのTab文字の表示幅"
set autoindent               "自動インデント"
set smartindent              "オートイデント"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 検索系
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set ignorecase      "大文字小文字を無視"
set smartcase       "ignorecaseと合わせることで, 小文字入力の時のみ大文字小文字を無視"
set incsearch       "インクリメンタルサーチ"
set hlsearch        "検索結果をハイライト"
set history=100     "コマンド、検索パターンを100個まで履歴に残す"

"ESCキー連打でハイライトを消す"
nnoremap <silent> <ESC><ESC> :nohlsearch<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 入力系
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set backspace=indent,eol,start   "挿入モードでバックスペースを有効にする"

"入力モードでのカーソル移動"
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

"折り返し時に表示行単位での移動できるようにする"
nnoremap j gj
nnoremap k gk

"保存時に行末の空白を削除する"
autocmd BufWritePre * :%s/\s\+$//ge

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ステータスラインの設定
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertStatuslineColor(mode)
  if a:mode == 'i'
    hi statusline guibg=DarkRed ctermfg=1 guifg=Black ctermbg=0
  elseif a:mode == 'r'
    hi statusline guibg=Purple ctermfg=5 guifg=Black ctermbg=0
  else
    hi statusline guibg=Cyan ctermfg=6 guifg=Black ctermbg=0
  endif
endfunction

au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertLeave * hi statusline guibg=DarkGrey ctermfg=8 guifg=White ctermbg=15

hi statusline guibg=DarkGrey ctermfg=8 guifg=White ctermbg=15

"ステータスラインに表示する情報の指定"
set statusline=%{expand('%:p:t')}\ %<[%{expand('%:p:h')}]%=\ %m%r%y%w[%{&fenc!=''?&fenc:&enc}][%{&ff}][%3l,%3c,%3p]

"ESC後にすぐ反映されない対策"
if has('unix') && !has('gui_running')
  inoremap <silent> <ESC> <ESC>
endif

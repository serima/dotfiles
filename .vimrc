" vim: set ts=4 sw=4 sts=0:
"-----------------------------------------------------------------------------
" Ê¸»ú¥³¡¼¥É´ØÏ¢
"
if &encoding !=# 'utf-8'
	set encoding=japan
	set fileencoding=japan
endif
if has('iconv')
	let s:enc_euc = 'euc-jp'
	let s:enc_jis = 'iso-2022-jp'
	" iconv¤¬eucJP-ms¤ËÂÐ±þ¤·¤Æ¤¤¤ë¤«¤ò¥Á¥§¥Ã¥¯
	if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
		let s:enc_euc = 'eucjp-ms'
		let s:enc_jis = 'iso-2022-jp-3'
	" iconv¤¬JISX0213¤ËÂÐ±þ¤·¤Æ¤¤¤ë¤«¤ò¥Á¥§¥Ã¥¯
	elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
		let s:enc_euc = 'euc-jisx0213'
		let s:enc_jis = 'iso-2022-jp-3'
	endif
	" fileencodings¤ò¹½ÃÛ
	if &encoding ==# 'utf-8'
		let s:fileencodings_default = &fileencodings
		let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
		let &fileencodings = &fileencodings .','. s:fileencodings_default
		unlet s:fileencodings_default
	else
		let &fileencodings = &fileencodings .','. s:enc_jis
		set fileencodings+=utf-8,ucs-2le,ucs-2
		if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
			set fileencodings+=cp932
			set fileencodings-=euc-jp
			set fileencodings-=euc-jisx0213
			set fileencodings-=eucjp-ms
			let &encoding = s:enc_euc
			let &fileencoding = s:enc_euc
		else
			let &fileencodings = &fileencodings .','. s:enc_euc
		endif
	endif
	" Äê¿ô¤ò½èÊ¬
	unlet s:enc_euc
	unlet s:enc_jis
endif
" ÆüËÜ¸ì¤ò´Þ¤Þ¤Ê¤¤¾ì¹ç¤Ï fileencoding ¤Ë encoding ¤ò»È¤¦¤è¤¦¤Ë¤¹¤ë
if has('autocmd')
	function! AU_ReCheck_FENC()
		if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
			let &fileencoding=&encoding
		endif
	endfunction
	autocmd BufReadPost * call AU_ReCheck_FENC()
endif
" ²þ¹Ô¥³¡¼¥É¤Î¼«Æ°Ç§¼±
set fileformats=unix,dos,mac
" ¢¢¤È¤«¡û¤ÎÊ¸»ú¤¬¤¢¤Ã¤Æ¤â¥«¡¼¥½¥ë°ÌÃÖ¤¬¤º¤ì¤Ê¤¤¤è¤¦¤Ë¤¹¤ë
if exists('&ambiwidth')
	set ambiwidth=double
endif

"-----------------------------------------------------------------------------
" ÊÔ½¸´ØÏ¢
"
"¥ª¡¼¥È¥¤¥ó¥Ç¥ó¥È¤¹¤ë
set autoindent
"¥Ð¥¤¥Ê¥êÊÔ½¸(xxd)¥â¡¼¥É¡Êvim -b ¤Ç¤Îµ¯Æ°¡¢¤â¤·¤¯¤Ï *.bin ¤ÇÈ¯Æ°¤·¤Þ¤¹¡Ë
augroup BinaryXXD
	autocmd!
	autocmd BufReadPre  *.bin let &binary =1
	autocmd BufReadPost * if &binary | silent %!xxd -g 1
	autocmd BufReadPost * set ft=xxd | endif
	autocmd BufWritePre * if &binary | %!xxd -r | endif
	autocmd BufWritePost * if &binary | silent %!xxd -g 1
	autocmd BufWritePost * set nomod | endif
augroup END

"-----------------------------------------------------------------------------
" ¸¡º÷´ØÏ¢
"
"¸¡º÷Ê¸»úÎó¤¬¾®Ê¸»ú¤Î¾ì¹ç¤ÏÂçÊ¸»ú¾®Ê¸»ú¤ò¶èÊÌ¤Ê¤¯¸¡º÷¤¹¤ë
set ignorecase
"¸¡º÷Ê¸»úÎó¤ËÂçÊ¸»ú¤¬´Þ¤Þ¤ì¤Æ¤¤¤ë¾ì¹ç¤Ï¶èÊÌ¤·¤Æ¸¡º÷¤¹¤ë
set smartcase
"¸¡º÷»þ¤ËºÇ¸å¤Þ¤Ç¹Ô¤Ã¤¿¤éºÇ½é¤ËÌá¤ë
set wrapscan
"¸¡º÷Ê¸»úÎóÆþÎÏ»þ¤Ë½ç¼¡ÂÐ¾ÝÊ¸»úÎó¤Ë¥Ò¥Ã¥È¤µ¤»¤Ê¤¤
set noincsearch

"-----------------------------------------------------------------------------
" Áõ¾þ´ØÏ¢
"
" http://winterdom.com/2008/08/molokaiforvim
set bg=dark
set t_Co=256
let g:molokai_original=1
colorscheme molokai
" ¥¹¥¯¥ê¥×¥È¼Â¹ÔÃæ¤Ë²èÌÌ¤òÉÁ²è¤·¤Ê¤¤
set lazyredraw
"¥·¥ó¥¿¥Ã¥¯¥¹¥Ï¥¤¥é¥¤¥È¤òÍ­¸ú¤Ë¤¹¤ë
if has("syntax")
	syntax on
endif
"¥«¡¼¥½¥ë¹Ô¤Ë²¼Àþ¤òÉ½¼¨
set cursorline
"¹ÔÈÖ¹æ¤òÉ½¼¨¤·¤Ê¤¤
set nonumber
"¥¿¥Ö¤Îº¸Â¦¤Ë¥«¡¼¥½¥ëÉ½¼¨
set listchars=tab:\ \ 
set list
"¥¿¥ÖÉý¤òÀßÄê¤¹¤ë
set tabstop=4
set shiftwidth=4
"ÆþÎÏÃæ¤Î¥³¥Þ¥ó¥É¤ò¥¹¥Æ¡¼¥¿¥¹¤ËÉ½¼¨¤¹¤ë
set showcmd
"³ç¸ÌÆþÎÏ»þ¤ÎÂÐ±þ¤¹¤ë³ç¸Ì¤òÉ½¼¨
set showmatch
"¸¡º÷·ë²ÌÊ¸»úÎó¤Î¥Ï¥¤¥é¥¤¥È¤òÍ­¸ú¤Ë¤¹¤ë
set hlsearch
"¥¹¥Æ¡¼¥¿¥¹¥é¥¤¥ó¤ò¾ï¤ËÉ½¼¨
set laststatus=2
"¥¹¥Æ¡¼¥¿¥¹¥é¥¤¥ó¤ËÊ¸»ú¥³¡¼¥É¤È²þ¹ÔÊ¸»ú¤òÉ½¼¨¤¹¤ë
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
"¹ÔËö¤Î¥¹¥Ú¡¼¥¹¤ò¶¯Ä´É½¼¨
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/
autocmd WinEnter * match WhitespaceEOL /\s\+$/

"-----------------------------------------------------------------------------
" ¥Þ¥Ã¥×ÄêµÁ
"
"¥Ð¥Ã¥Õ¥¡°ÜÆ°ÍÑ¥­¡¼¥Þ¥Ã¥×
" F2: Á°¤Î¥Ð¥Ã¥Õ¥¡
" F3: ¼¡¤Î¥Ð¥Ã¥Õ¥¡
" F4: ¥Ð¥Ã¥Õ¥¡ºï½ü
map <F2> <ESC>:bp<CR>
map <F3> <ESC>:bn<CR>
map <F4> <ESC>:bw<CR>
"É½¼¨¹ÔÃ±°Ì¤Ç¹Ô°ÜÆ°¤¹¤ë
nnoremap j gj
nnoremap k gk
"¥Õ¥ì¡¼¥à¥µ¥¤¥º¤òÂÕÂÆ¤ËÊÑ¹¹¤¹¤ë
map <kPlus> <C-W>+
map <kMinus> <C-W>-
"Gtags 
"½àÈ÷
"map <C-g> :Gtags
"³«¤¤¤Æ¤¤¤ë¥Õ¥¡¥¤¥ë¤ËÄêµÁ¤µ¤ì¤Æ¤¤¤ë´Ø¿ô¤Î°ìÍ÷¤òÉ½¼¨
"map <C-i> :Gtags -f %<CR>
"¸½ºß¥«¡¼¥½¥ë¤¬¤¢¤ë°ÌÃÖ¤Î´Ø¿ô¤Ø¥¸¥ã¥ó¥×
"map <C-j> :GtagsCursor<CR>
"¼¡¤Î¸¡º÷·ë²Ì
"map <C-n> :cn<CR>
"Á°¤Î¸¡º÷·ë²Ì
"map <C-p> :cp<CR>
"¸¡º÷·ë²ÌWindow¤òÊÄ¤¸¤ë
"map <C-q> <C-w><C-w><C-w>q
"----------------------------------------------------
" GNU GLOBAL(gtags)
"----------------------------------------------------
" ¸¡º÷·ë²ÌWindow¤òÊÄ¤¸¤ë
nnoremap <C-q> <C-w><C-w><C-w>q
" Grep ½àÈ÷
nnoremap <C-g> :Gtags -g
" ¤³¤Î¥Õ¥¡¥¤¥ë¤Î´Ø¿ô°ìÍ÷
nnoremap <C-l> :Gtags -f %<CR>
" ¥«¡¼¥½¥ë°Ê²¼¤ÎÄêµÁ¸µ¤òÃµ¤¹
nnoremap <C-j> :Gtags <C-r><C-w><CR>
" ¥«¡¼¥½¥ë°Ê²¼¤Î»ÈÍÑ²Õ½ê¤òÃµ¤¹
nnoremap <C-k> :Gtags -r <C-r><C-w><CR>
" ¼¡¤Î¸¡º÷·ë²Ì
nnoremap <C-n> :cn<CR>
" Á°¤Î¸¡º÷·ë²Ì
nnoremap <C-p> :cp<CR>

"screen¤Îstatus line¤Îtitle¤òvim¤ÎbufEnter¥Õ¥Ã¥¯¤Ç¸½ºßÊÔ½¸Ãæ¤Î¥Ð¥Ã¥Õ¥¡Ì¾¤Ë¤¹¤ë
"http://d.hatena.ne.jp/ysano2005/20061118/1163829796
function SetScreenTabName(name)
  let arg = 'k' . a:name . '\\'
  silent! exe '!echo -n "' . arg . "\""
endfunction

if &term =~ "screen"
  autocmd VimLeave * call SetScreenTabName('** free **')
  autocmd BufEnter * if bufname("") !~ "[A-Za-z0-9\]*://" | call SetScreenTabName("%") | endif 
endif

"vim plugin yanktmp
map <silent> sy :call YanktmpYank()<cr>
map <silent> sp :call YanktmpPaste_p()<cr>
map <silent> sP :call YanktmpPaste_P()<cr> 
let g:yanktmp_file = '/home/serima/tmp/yanktmp'

"php syntax check
":make
set makeprg=php\ -l\ %
set errorformat=%m\ in\ %f\ on\ line\ %l

"¥«¡¼¥½¥ë¤¬¤¢¤ë¼¡¤Î¹Ô¤Ëerror_log¤òÆþ¤ì¤ë
nmap <C-e><C-r> :r ~/error_log.php<CR>
"¸½ºßÊÔ½¸¤·¤Æ¤¤¤ë¥Õ¥¡¥¤¥ë¤Î¥Õ¥ë¥Ñ¥¹¤òÉ½¼¨
nmap <C-p><C-w><C-d> :echo expand("%:p")<CR> 

" pathogen
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" VCSCommand
noremap <Space>s <C-w>o:VCSVimDiff<CR><C-w>p<
"<Leader>dq¤ÇDiff¤«¤éÈ´¤±¤ë
noremap <Space>q :winc l<CR>:bw<CR>:diffoff<CR>

"¹Ô¤òÁªÂò¤·¤Æ¤¤¤ë´Ö¡¢Tab¥­¡¼¤Ï¡Ö¹ÔÆ¬¤Î¥¿¥Ö¤Ø¤ÎÃÖ´¹+ÁªÂòÈÏ°Ï¤òÉü³è¡×¤È¤¤¤¦°ÕÌ£
vmap <Tab> :s/^/\t/<CR>gv
vmap <S-Tab> :s/^\t//<CR>gv

"let g:indent_guides_enable_on_vim_startup=1
"let g:indent_guides_color_change_percent=2
"let g:indent_guides_guide_size=1

"vimtab
set showtabline=2
map tn :tabnext<CR>
map tp :tabprev<CR>
map tc :tabnew<CR>
map td :tabclose<CR>

""" Unite.vim
" µ¯Æ°»þ¤Ë¥¤¥ó¥µ¡¼¥È¥â¡¼¥É¤Ç³«»Ï
let g:unite_enable_start_insert = 1

" ¥¤¥ó¥µ¡¼¥È¡¿¥Î¡¼¥Þ¥ë¤É¤Á¤é¤«¤é¤Ç¤â¸Æ¤Ó½Ð¤»¤ë¤è¤¦¤Ë¥­¡¼¥Þ¥Ã¥×
"nnoremap <silent> <C-f> :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
"inoremap <silent> <C-f> <ESC>:<C-u>UniteWithBufferDir -buffer-name=files file<CR>
"nnoremap <silent> <C-b> :<C-u>Unite buffer file_mru<CR>
"inoremap <silent> <C-b> <ESC>:<C-u>Unite buffer file_mru<CR>

" ¥Ð¥Ã¥Õ¥¡°ìÍ÷
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
" ¥Õ¥¡¥¤¥ë°ìÍ÷
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" ¥ì¥¸¥¹¥¿°ìÍ÷
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
" ºÇ¶á»ÈÍÑ¤·¤¿¥Õ¥¡¥¤¥ë°ìÍ÷
nnoremap <silent> ,um :<C-u>Unite file_mru<CR>
" Á´Éô¾è¤»
nnoremap <silent> ,ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>

" unite.vim¾å¤Ç¤Î¥­¡¼¥Þ¥Ã¥Ô¥ó¥°
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
  " Ã±¸ìÃ±°Ì¤«¤é¥Ñ¥¹Ã±°Ì¤Çºï½ü¤¹¤ë¤è¤¦¤ËÊÑ¹¹(vsp¤·¤Æ¤ë¤È¤­¤Ï¥³¥ó¥Õ¥ê¥¯¥È¤¹¤ë...)
  imap <buffer> <C-w> <Plug>(unite_delete_backward_path)
  " ESC¥­¡¼¤ò2²ó²¡¤¹¤È½ªÎ»¤¹¤ë
  nmap <silent><buffer> <ESC><ESC> q
  imap <silent><buffer> <ESC><ESC> <ESC>q
endfunction

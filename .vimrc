" vim: set ts=4 sw=4 sts=0:
"-----------------------------------------------------------------------------
" ʸ�������ɴ�Ϣ
"
if &encoding !=# 'utf-8'
	set encoding=japan
	set fileencoding=japan
endif
if has('iconv')
	let s:enc_euc = 'euc-jp'
	let s:enc_jis = 'iso-2022-jp'
	" iconv��eucJP-ms���б����Ƥ��뤫������å�
	if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
		let s:enc_euc = 'eucjp-ms'
		let s:enc_jis = 'iso-2022-jp-3'
	" iconv��JISX0213���б����Ƥ��뤫������å�
	elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
		let s:enc_euc = 'euc-jisx0213'
		let s:enc_jis = 'iso-2022-jp-3'
	endif
	" fileencodings����
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
	" ������ʬ
	unlet s:enc_euc
	unlet s:enc_jis
endif
" ���ܸ��ޤޤʤ����� fileencoding �� encoding ��Ȥ��褦�ˤ���
if has('autocmd')
	function! AU_ReCheck_FENC()
		if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
			let &fileencoding=&encoding
		endif
	endfunction
	autocmd BufReadPost * call AU_ReCheck_FENC()
endif
" ���ԥ����ɤμ�ưǧ��
set fileformats=unix,dos,mac
" ���Ȥ�����ʸ�������äƤ⥫��������֤�����ʤ��褦�ˤ���
if exists('&ambiwidth')
	set ambiwidth=double
endif

"-----------------------------------------------------------------------------
" �Խ���Ϣ
"
"�����ȥ���ǥ�Ȥ���
set autoindent
"�Х��ʥ��Խ�(xxd)�⡼�ɡ�vim -b �Ǥε�ư���⤷���� *.bin ��ȯư���ޤ���
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
" ������Ϣ
"
"����ʸ���󤬾�ʸ���ξ�����ʸ����ʸ������̤ʤ���������
set ignorecase
"����ʸ�������ʸ�����ޤޤ�Ƥ�����϶��̤��Ƹ�������
set smartcase
"�������˺Ǹ�ޤǹԤä���ǽ�����
set wrapscan
"����ʸ�������ϻ��˽缡�о�ʸ����˥ҥåȤ����ʤ�
set noincsearch

"-----------------------------------------------------------------------------
" ������Ϣ
"
" http://winterdom.com/2008/08/molokaiforvim
set bg=dark
set t_Co=256
let g:molokai_original=1
colorscheme molokai
" ������ץȼ¹���˲��̤����褷�ʤ�
set lazyredraw
"���󥿥å����ϥ��饤�Ȥ�ͭ���ˤ���
if has("syntax")
	syntax on
endif
"��������Ԥ˲�����ɽ��
set cursorline
"���ֹ��ɽ�����ʤ�
set nonumber
"���֤κ�¦�˥�������ɽ��
set listchars=tab:\ \ 
set list
"�����������ꤹ��
set tabstop=4
set shiftwidth=4
"������Υ��ޥ�ɤ򥹥ơ�������ɽ������
set showcmd
"������ϻ����б������̤�ɽ��
set showmatch
"�������ʸ����Υϥ��饤�Ȥ�ͭ���ˤ���
set hlsearch
"���ơ������饤�����ɽ��
set laststatus=2
"���ơ������饤���ʸ�������ɤȲ���ʸ����ɽ������
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
"�����Υ��ڡ�����Ĵɽ��
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/
autocmd WinEnter * match WhitespaceEOL /\s\+$/

"-----------------------------------------------------------------------------
" �ޥå����
"
"�Хåե���ư�ѥ����ޥå�
" F2: ���ΥХåե�
" F3: ���ΥХåե�
" F4: �Хåե����
map <F2> <ESC>:bp<CR>
map <F3> <ESC>:bn<CR>
map <F4> <ESC>:bw<CR>
"ɽ����ñ�̤ǹ԰�ư����
nnoremap j gj
nnoremap k gk
"�ե졼�ॵ���������Ƥ��ѹ�����
map <kPlus> <C-W>+
map <kMinus> <C-W>-
"Gtags 
"����
"map <C-g> :Gtags
"�����Ƥ���ե�������������Ƥ���ؿ��ΰ�����ɽ��
"map <C-i> :Gtags -f %<CR>
"���ߥ������뤬������֤δؿ��إ�����
"map <C-j> :GtagsCursor<CR>
"���θ������
"map <C-n> :cn<CR>
"���θ������
"map <C-p> :cp<CR>
"�������Window���Ĥ���
"map <C-q> <C-w><C-w><C-w>q
"----------------------------------------------------
" GNU GLOBAL(gtags)
"----------------------------------------------------
" �������Window���Ĥ���
nnoremap <C-q> <C-w><C-w><C-w>q
" Grep ����
nnoremap <C-g> :Gtags -g
" ���Υե�����δؿ�����
nnoremap <C-l> :Gtags -f %<CR>
" ��������ʲ����������õ��
nnoremap <C-j> :Gtags <C-r><C-w><CR>
" ��������ʲ��λ��Ѳս��õ��
nnoremap <C-k> :Gtags -r <C-r><C-w><CR>
" ���θ������
nnoremap <C-n> :cn<CR>
" ���θ������
nnoremap <C-p> :cp<CR>

"screen��status line��title��vim��bufEnter�եå��Ǹ����Խ���ΥХåե�̾�ˤ���
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
let g:yanktmp_file = $HOME . '/tmp/yanktmp'

"php syntax check
":make
set makeprg=php\ -l\ %
set errorformat=%m\ in\ %f\ on\ line\ %l

"�������뤬���뼡�ιԤ�error_log�������
nmap <C-e><C-r> :r ~/error_log.php<CR>
"�����Խ����Ƥ���ե�����Υե�ѥ���ɽ��
nmap <C-p><C-w><C-d> :echo expand("%:p")<CR> 

" VCSCommand
noremap <Space>s <C-w>o:VCSVimDiff<CR><C-w>p<
"<Leader>dq��Diff����ȴ����
noremap <Space>q :winc l<CR>:bw<CR>:diffoff<CR>

"�Ԥ����򤷤Ƥ���֡�Tab�����ϡֹ�Ƭ�Υ��֤ؤ��ִ�+�����ϰϤ�����פȤ�����̣
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
" ��ư���˥��󥵡��ȥ⡼�ɤǳ���
let g:unite_enable_start_insert = 1

" ���󥵡��ȡ��Ρ��ޥ�ɤ��餫��Ǥ�ƤӽФ���褦�˥����ޥå�
"nnoremap <silent> <C-f> :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
"inoremap <silent> <C-f> <ESC>:<C-u>UniteWithBufferDir -buffer-name=files file<CR>
"nnoremap <silent> <C-b> :<C-u>Unite buffer file_mru<CR>
"inoremap <silent> <C-b> <ESC>:<C-u>Unite buffer file_mru<CR>

" �Хåե�����
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
" �ե��������
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" �쥸��������
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
" �Ƕ���Ѥ����ե��������
nnoremap <silent> ,um :<C-u>Unite file_mru<CR>
" �����褻
nnoremap <silent> ,ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>

" unite.vim��ǤΥ����ޥåԥ�
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
  " ñ��ñ�̤���ѥ�ñ�̤Ǻ������褦���ѹ�(vsp���Ƥ�Ȥ��ϥ���եꥯ�Ȥ���...)
  imap <buffer> <C-w> <Plug>(unite_delete_backward_path)
  " ESC������2�󲡤��Ƚ�λ����
  nmap <silent><buffer> <ESC><ESC> q
  imap <silent><buffer> <ESC><ESC> <ESC>q
endfunction

" neobundle
set nocompatible
filetype plugin indent off

if has('vim_starting')
   if &compatible
     set nocompatible               " Be iMproved
   endif

   " Required:
   set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/dotfiles/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
NeoBundle 'Shougo/unite.vim'
NeoBundle 'rtakasuke/yanktmp.vim'
NeoBundle 'grep.vim'

call neobundle#end()

filetype plugin indent on

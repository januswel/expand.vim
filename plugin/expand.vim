" vim plugin file
" Filename:     expand.vim
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Dependency: {{{1
"   This plugin requires following file.
"
"   http://github.com/januswel/jwlib.git
"       autoload/jwlib/buf/replace.vim

" License:      MIT License {{{1
"   See under URL.  Note that redistribution is permitted with LICENSE.
"   https://github.com/januswel/expand.vim/blob/master/LICENSE

" preparations {{{1
" check if this plugin is already loaded or not
if exists('loaded_expand')
    finish
endif
let loaded_expand = 1

" reset the value of 'cpoptions' for portability
let s:save_cpoptions = &cpoptions
set cpoptions&vim

" main {{{1
" mappings {{{2
if !(exists('no_plugin_maps') && no_plugin_maps)
    \ && !(exists('no_expand_maps') && no_expand_maps)
    if !hasmapto('<Plug>ExpandExpression', 'n')
        nmap <unique><Leader>ex
                    \ <Plug>ExpandExpression
    endif

    if !hasmapto('<Plug>EvalExpression', 'n')
        nmap <unique><Leader>ev
                    \ <Plug>EvalExpression
    endif
endif

nnoremap <silent><Plug>ExpandExpression
            \ :silent call <SID>ExpandExpression()<CR>
nnoremap <silent><Plug>EvalExpression
            \ :silent call <SID>EvalExpression()<CR>

" functions {{{2
function! s:ExpandExpression()
    return jwlib#buf#replace#CWORD(function('expand'), '<e-target>')
endfunction

function! s:EvalExpression()
    return jwlib#buf#replace#CWORD(function('eval'), '<target>')
endfunction

" post-processings {{{1
" restore the value of 'cpoptions'
let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions

" }}}1
" vim: ts=4 sw=4 sts=0 et fdm=marker fdc=3

let s:assert = themis#helper('assert')

let g:deepl#endpoint = 'http://localhost:8080/v2/translate'
let g:deepl#auth_key = 'test_auth_key'

let s:translate = themis#suite('deepl')

function! s:translate.hello()
  let res = deepl#translate('こんにちは', 'EN', 'JA')
  call s:assert.equals(res, 'Hello')
endfunction

function! s:translate.escape_double_quote()
  let res = deepl#translate('Getting started with "Hello World"', 'JA', 'EN')
  call s:assert.equals(res, '"Hello World"を始めよう')
endfunction

function! s:translate.escape_back_quote()
  let res = deepl#translate('Getting started with `Hello World`', 'JA', 'EN')
  call s:assert.equals(res, '`Hello World`を始めよう')
endfunction

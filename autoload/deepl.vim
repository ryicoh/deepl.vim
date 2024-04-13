" Send a translation request to deepl using curl
function! deepl#translate(input, target_lang, source_lang = "")
  let cmd = "curl -sS " .. g:deepl_endpoint
  let cmd = cmd .. ' -d "auth_key=' .. g:deepl_auth_key .. '"'
  let cmd = cmd .. ' -d ' .. shellescape('text=' .. a:input)
  let cmd = cmd .. ' -d "target_lang=' .. a:target_lang .. '"'

  if a:source_lang != ""
    let cmd = cmd .. ' -d "source_lang=' .. a:source_lang .. '"'
  endif

  try
    const res = json_decode(system(cmd))
    return res["translations"][0]["text"]

  catch /.*/
    echoerr "error: " .. v:exception
  endtry
endfunction

" Replace visual selection
" ref: https://github.com/christianrondeau/vim-base64/blob/d15253105f6a329cd0632bf9dcbf2591fb5944b8/autoload/base64.vim#L29
function! deepl#v(target_lang, source_lang = "")
  " Preserve line breaks
  let l:paste = &paste
  set paste

  try
    " Apply transformation to the text
    if a:source_lang == ""
      execute "normal! c\<C-r>=deepl#translate(@\", '" .. a:target_lang .. "')\<CR>\<Esc>"
    else
      execute "normal! c\<C-r>=deepl#translate(@\", '" .. a:target_lang .. "', '" .. a:source_lang .. "')\<CR>\<Esc>"
    endif
  finally
    " Select the new text
    normal! `[v`]h
    " Revert to previous mode
    let &paste = l:paste
  endtry
endfunction

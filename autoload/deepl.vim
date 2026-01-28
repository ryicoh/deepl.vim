" Send a translation request to deepl using curl
function! deepl#translate(input, target_lang, source_lang = "")
  let data = #{
        \ text: [a:input],
        \ target_lang: a:target_lang,
        \ }
  if a:source_lang != ""
    let data.source_lang = a:source_lang
  endif

  let cmd = "curl -sS " .. g:deepl#endpoint
  let cmd = cmd .. ' -H "Authorization: DeepL-Auth-Key ' .. g:deepl#auth_key .. '"'
  let cmd = cmd .. ' -H "Content-Type: application/json"'
  let cmd = cmd .. ' -d ' .. shellescape(json_encode(data))

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

  " Avoid superfluous trailing newline after translating a visual linewise
  " selection by changing it to a characterwise selection.
  if mode() == "V"
    execute "normal! \<ESC>`<v`>h\<ESC>gv"
  endif

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

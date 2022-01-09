" Send a translation request to deepl using curl
function! deepl#translate(input, lang)
  let cmd = "curl -sS ".g:deepl#endpoint
  let cmd = cmd.' -d "auth_key='.g:deepl#auth_key.'"'
  let cmd = cmd.' -d "text='.a:input.'"'
  let cmd = cmd.' -d "target_lang='.a:lang.'"'

  try
    const res = json_decode(system(cmd))
    return res["translations"][0]["text"]

  catch /.*/
    echoerr "error: " . v:exception
  endtry
endfunction


" Replace visual selection
" ref: https://github.com/christianrondeau/vim-base64/blob/d15253105f6a329cd0632bf9dcbf2591fb5944b8/autoload/base64.vim#L29
function! deepl#v(lang)
	" Preserve line breaks
	let l:paste = &paste
	set paste
	" Reselect the visual mode text
	normal! gv
	" Apply transformation to the text
	execute "normal! c\<c-r>=deepl#translate(@\", '".a:lang."')\<cr>\<esc>"
	" Select the new text
	normal! `[v`]h
	" Revert to previous mode
	let &paste = l:paste
endfunction
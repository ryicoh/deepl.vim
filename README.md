# deepl.vim [![Test](https://github.com/ryicoh/deepl.vim/actions/workflows/test.yml/badge.svg)](https://github.com/ryicoh/deepl.vim/actions/workflows/test.yml)

DeepL translation plugin for Vim/NeoVim.

## Demo

https://user-images.githubusercontent.com/37844673/148679023-6814c111-6ada-4279-99ea-cd29afc6a1f3.mov

## Requirements
* DeepL account (https://www.deepl.com)
* curl

## Installation

For [vim-plug](https://github.com/junegunn/vim-plug)

```vim
Plug "ryicoh/deepl.vim"
```

For [dein.vim](https://github.com/Shougo/dein.vim)

```vim
call dein#add("ryicoh/deepl.vim")
```

## Configuration

```vim
let g:deepl#endpoint = "https://api-free.deepl.com/v2/translate"
let g:deepl#auth_key = "00000000-0000-0000-0000-000000000000:fx" " or readfile(expand('~/.config/deepl.auth_key'))[0]

" replace a visual selection
vmap t<C-e> <Cmd>call deepl#v("EN")<CR>
vmap t<C-j> <Cmd>call deepl#v("JA")<CR>

" translate a current line and display on a new line
nmap t<C-e> yypV<Cmd>call deepl#v("EN")<CR>
nmap t<C-j> yypV<Cmd>call deepl#v("JA")<CR>

" specify the source language
" translate from FR to EN
nmap t<C-e> yypV<Cmd>call deepl#v("EN", "FR")<CR>
```

## License

MIT

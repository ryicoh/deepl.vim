# deepl.vim

Deepl translation plugin for Vim/NeoVim.

## Demo

https://user-images.githubusercontent.com/37844673/148679023-6814c111-6ada-4279-99ea-cd29afc6a1f3.mov

## Requirements
* DeepL account (https://www.deepl.com)
* curl

## Installation

For [vim-plug](https://github.com/junegunn/vim-plug)
```
Plug "ryicoh/deepl.vim"
```

For [dein.vim](https://github.com/Shougo/dein.vim)
```
Plug "ryicoh/deepl.vim"
```

## Configuration
```vim
let g:deepl#endpoint = "https://api-free.deepl.com/v2/translate"
let g:deepl#auth_key = "00000000-0000-0000-0000-000000000000:fx"

vmap t<C-e> <Cmd>call deepl#v("EN")<CR>
vmap t<C-j> <Cmd>call deepl#v("JA")<CR>
```

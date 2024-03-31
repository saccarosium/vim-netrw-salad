# Netrw Salad

The goal of this plugin is to be as unintrusive as possible to the default netrw experience. While trying to make some modification to improve usability.

## Features

* More sensible defaults
* Press `-` to open directory listing where the current file is located
* Quickly navigate between files and directories using `hjkl`
* When deleting or rename a file the associated buffer will be deleted

## Installation

</details>
<details><summary> <a href="https://github.com/junegunn/vim-plug">vim-plug</a> </summary>

vim9script:

```vim
plug#begin()
Plug 'saccarosium/vim-netrw-salad'
plug#end()
```

legacy vimscript:

```vim
call plug#begin()
Plug 'saccarosium/vim-netrw-salad'
call plug#end()
```
</details>

</details>
<details><summary> <a href="https://github.com/k-takata/minpac">minpac</a> </summary>

vim9script:

```vim
minpac#add('saccarosium/vim-netrw-salad')
```

legacy vimscript:

```vim
call minpac#add('saccarosium/vim-netrw-salad')
```

</details>

<details><summary> <a href="https://vimhelp.org/repeat.txt.html#packages">built-in</a> </summary>

```sh
mkdir -p $HOME/.vim/pack/packs/start
cd $HOME/.vim/pack/packs/start
git clone https://github.com/saccarosium/vim-netrw-salad
```

</details>

## Documentation

See `doc/netrw-salad.txt`

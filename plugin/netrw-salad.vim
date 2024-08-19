vim9script

import autoload "../import/config.vim"

var conf = config.Get()

if (conf.configure_netrw)
  g:netrw_hide = 0
  g:netrw_preview = 1
  g:netrw_altfile = 1
endif

if (config.CanMap())
  nnoremap - :Explore<CR>
endif

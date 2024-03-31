vim9script

import autoload "../autoload/netrw_salad/config.vim"

var conf = config.Get()

if (conf.configure_netrw)
  g:netrw_hide = 0
  g:netrw_preview = 1
  g:netrw_altfile = 1
endif

if (config.CanMap())
  nnoremap - :Explore<CR>
endif

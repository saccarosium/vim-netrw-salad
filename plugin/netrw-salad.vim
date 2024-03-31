vim9script

import autoload "../autoload/netrw_salad/private.vim" as api

var config = api.GetConfig()

if (config.configure_netrw)
  g:netrw_hide = 0
  g:netrw_preview = 1
  g:netrw_altfile = 1
endif

if (api.CanMap())
  nnoremap - :Explore<CR>
endif

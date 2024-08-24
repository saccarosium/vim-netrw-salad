vim9script

import "netrw_salad/config.vim"

var conf = config.Get()

if (conf.configure_netrw)
  g:netrw_hide = 0
  g:netrw_preview = 1
  g:netrw_altfile = 1
endif

def Explore()
  Explore
  exec $":/{escape(expand("#:t"), &shellslash ? '\' : '/')}/"
enddef

nnoremap <Plug>NetrwSaladExplore <scriptcmd>Explore()<CR>

if (config.CanMap())
  nnoremap <nowait> - <Plug>NetrwSaladExplore
endif

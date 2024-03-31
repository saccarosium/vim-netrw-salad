vim9script

# Imports: {{{

import autoload "../autoload/netrw_salad/config.vim"

# }}}
# File Helpers: {{{ 

def FileValid(file: string): bool
  return filereadable(file) || isdirectory(file)
enddef

def Slash(): string
  return &shellslash ? '\' : '/'
enddef

def GetFileUnderCursor(): string
  var line = getline('.')
  var dir = b:netrw_curdir
  var file = dir .. Slash() .. line
  if line ==# "./" || line ==# '../'
    file = line
  endif
  return FileValid(file) ? file : ""
enddef

# }}}
# Buffer Helpers: {{{

def DeleteOpenBuffer(file: string)
  if !bufexists(file)
    return
  endif
  execute ":bwipeout! " .. file
enddef

def RenameOpenBuffer(src: string, dst: string)
  if !bufexists(src)
    return
  endif
  var win = filter(getwininfo(), (_, x) => { 
    return getbufinfo(x.bufnr)[0].name ==# src
  })
  if !empty(win)
    if win_gotoid(win[0].winnr->win_getid())
      execute "edit " .. dst
      :wincmd p
    endif
  endif
  execute ":bwipeout! " .. src
enddef

# }}}
# User Interaction: {{{

def PromptUser(msg: string, dir: bool): string
  var confirm_choice = dir ? "[y(es),n(o),a(ll)] " : "[y(es),n(o)] "
  if msg[-1] != ' '
    confirm_choice = ' ' .. confirm_choice
  endif
  var new_msg = msg .. confirm_choice
  :echohl Statement
  inputsave()
  var userin = input(new_msg, "")
  inputrestore()
  :echohl NONE
  if userin =~# 'y\%[es]'
    return "yes"
  elseif userin =~# 'n\%[o]'
    return "no"
  elseif userin =~# 'a\%[ll]'
    return "all"
  endif
  return ""
enddef

# }}}
# Main Functions: {{{

def Delete(file: string)
  if !FileValid(file)
    echoerr "File is not readable"
    return
  endif
  var isdir = isdirectory(file)
  var in = PromptUser("Confirm deletion of <" .. file .. ">", isdir)
  var failed: number
  if isdir && in ==# "all"
    failed = delete(file, "rf")
  elseif isdir && in ==# "yes"
    failed = delete(file, "d")
  elseif in ==# "yes"
    failed = delete(file)
  else
    return
  endif
  if failed == -1
    echoerr "Error while deleting file"
    return
  endif
  DeleteOpenBuffer(file)
  feedkeys("\<Plug>NetrwRefresh")
enddef

def DeleteFileUnderCursor()
  var file = GetFileUnderCursor()
  if empty(file)
    return
  endif
  Delete(file)
enddef

def Rename(src: string, dst: string)
  if !FileValid(src)
    echoerr "File is not readable"
    return
  endif
  var failed = rename(src, dst)
  if failed
    echoerr "Error while deleting file"
    return
  endif
  RenameOpenBuffer(src, dst)
  feedkeys("\<Plug>NetrwRefresh")
  return
enddef

def RenameFileUnderCursor()
  var src = GetFileUnderCursor()
  if empty(src)
    return
  endif
  var msg = printf("Moving %s to : ", src)
  var dst = input(msg, src)
  if empty(dst)
    return
  endif
  Rename(src, dst)
enddef

# }}}
# Mappings: {{{

nnoremap <buffer> <silent> <Plug>NetrwSaladDelete <scriptcmd>DeleteFileUnderCursor()<CR>
nnoremap <buffer> <silent> <Plug>NetrwSaladRename <scriptcmd>RenameFileUnderCursor()<CR>

if (config.CanMap())
  nnoremap <buffer> <silent> <nowait> D <Plug>NetrwSaladDelete
  nnoremap <buffer> <silent> <nowait> R <Plug>NetrwSaladRename

  nmap <buffer> h ^-
  nmap <buffer> l <CR>
endif

# }}}

# vim:foldmethod=marker

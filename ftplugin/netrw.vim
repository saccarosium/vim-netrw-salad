vim9script

# Imports: {{{
import autoload "../autoload/netrw_salad/private.vim" as api
# }}}

# Private Functions: {{{
def Delete(file: string)
  if !api.FileValid(file)
    echoerr "File is not readable"
    return
  endif
  if api.PromptUser("Confirm deletion of <" .. file .. ">")
    var failed = delete(file)
    if failed == -1
      echoerr "Error while deleting file"
      return
    endif
    api.ResolveOpenBuffer(file)
    feedkeys("\<Plug>NetrwRefresh")
  endif
enddef

def DeleteFileUnderCursor()
  var file = api.GetFileUnderCursor()
  if empty(file)
    return
  endif
  Delete(file)
enddef

def Rename(src: string, dst: string)
  if !api.FileValid(src)
    echoerr "File is not readable"
    return
  endif
  var failed = rename(src, dst)
  if failed
    echoerr "Error while deleting file"
    return
  endif
  api.ResolveOpenBuffer(src)
  feedkeys("\<Plug>NetrwRefresh")
  return
enddef

def RenameFileUnderCursor()
  var src = api.GetFileUnderCursor()
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

if (api.CanMap())
  nnoremap <buffer> <silent> <nowait> q <C-^>
  nnoremap <buffer> . :<C-U> <C-R>=netrw_salad#private#GetFileUnderCursor()<CR><Home>
  nnoremap <buffer> <silent> <nowait> D <Plug>NetrwSaladDelete
  nnoremap <buffer> <silent> <nowait> R <Plug>NetrwSaladRename

  nmap <buffer> h ^-
  nmap <buffer> l <CR>
  nmap <buffer> ! .!
endif
# }}}

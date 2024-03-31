vim9script

import autoload "./private.vim"

export def PromptUser(msg: string): bool
  return private.PromptUser(msg)
enddef

export def GetFileUnderCursor(): string
  return private.GetFileUnderCursor()
enddef

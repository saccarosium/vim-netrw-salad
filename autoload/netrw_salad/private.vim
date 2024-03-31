vim9script

# Configuration: {{{
var config: dict<bool>

export def GetConfig(): dict<bool>
  if (empty(config))
    var user_config = get(g:, "netrw_salad_settings", {})
    config = extend({
      configure_netrw: true,
      map_keys: true,
    }, user_config, "force")
  endif
  return config
enddef

export def CanMap(): bool
  if (empty(config))
    config = GetConfig()
  endif
  return !exists('no_plugin_maps') && !exists('g:no_plugin_maps') && config.map_keys
enddef
# }}}

# File Helpers: {{{ 
export def FileValid(file: string): bool
  return filereadable(file) || isdirectory(file)
enddef

export def Slash(): string
  return &shellslash ? '\' : '/'
enddef

export def GetFileUnderCursor(): string
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
export def ResolveOpenBuffer(file: string)
  if !bufexists(file)
    return
  endif
  execute ":bwipeout! " .. file
enddef
# }}}

# User Interaction: {{{
export def PromptUser(msg: string): bool
  var confirm_choice = "[y(es),n(o)] "
  if msg[-1] != ' '
    confirm_choice = ' ' .. confirm_choice
  endif
  var new_msg = msg .. confirm_choice
  :echohl Statement
  inputsave()
  var userin = input(new_msg, "")
  inputrestore()
  :echohl NONE
  return userin =~# 'y\%[es]'
enddef
# }}}

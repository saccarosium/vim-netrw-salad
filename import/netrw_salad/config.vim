vim9script

var config = {
  configure_netrw: true,
  map_keys: true,
}

export def Get(): dict<bool>
  var user_config = get(g:, "netrw_salad_settings", {})
  config->extend(user_config, "force")
  return config
enddef

export def CanMap(): bool
  config = Get()
  return !exists('no_plugin_maps') && !exists('g:no_plugin_maps') && config.map_keys
enddef

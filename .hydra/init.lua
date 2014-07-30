require "arxanas/init"
douserfile "arxanas/update_checker"
douserfile "arxanas/planar"
douserfile "arxanas/app_binder"

HYPER = {"ctrl", "cmd", "alt", "shift"}


function on_startup()
  hydra.autolaunch.set(true)
  hydra.dockicon.hide()
  arxanas.update_checker.check_for_updates()
end

function init_planes()
  local plane_manager = arxanas.plane_manager.new({mods = HYPER, key = "`"})
  plane_manager.on_break = function()
    hydra.alert("Break!", 0.5)
  end

  local default_plane = plane_manager:get_default_plane()
  default_plane:add_hotkey_no_switch({mods = HYPER, key = "r", fn = hydra.reload})
  default_plane:add_hotkey_no_switch({mods = HYPER, key = "v", fn = hydra.reload})

  local app_binder = arxanas.app_binder.new(
    plane_manager,
    HYPER,
    {mods = HYPER, key = "SPACE"},
    {mods = HYPER, key = "TAB"}
  )
end

function main()
  hydra.alert("Reloaded hydra.", 0.5)

  on_startup()
  init_planes()

  -- TODO: enable in regular mode.
  -- hotkey.bind(HYPER, "r", hydra.reload):enable()
end

main()

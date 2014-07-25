function douserfile(package_name)
  dofile(package.searchpath(package_name, package.path))
end
douserfile "arxanas/update_checker"
douserfile "arxanas/planar"
douserfile "arxanas/app_binder"

HYPER = {"ctrl", "cmd", "alt", "shift"}


function on_startup()
  autolaunch.set(true)
  arxanas.update_checker.check_for_updates()
end

function init_planes()
  local plane_manager = arxanas.planar.plane_manager.new(hotkey.new(HYPER, "`"))
  local default_plane = plane_manager:get_default_plane()
  default_plane:add_hotkey_no_switch(hotkey.new(HYPER, "r", hydra.reload))

  local app_binger = arxanas.app_binder.new(
    plane_manager,
    HYPER,
    hotkey.new(HYPER, "g"),
    hotkey.new(HYPER, "-")
  )
end

function main()
  hydra.alert("Reloaded hydra.")

  on_startup()
  init_planes()

  -- TODO: enable in regular mode.
  -- hotkey.bind(HYPER, "r", hydra.reload):enable()
end

main()

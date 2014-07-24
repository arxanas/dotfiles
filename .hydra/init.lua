function douserfile(package_name)
  dofile(package.searchpath(package_name, package.path))
end
douserfile "arxanas/update_checker"
douserfile "arxanas/planar"

HYPER = {"ctrl", "cmd"}


function on_startup()
  autolaunch.set(true)
  arxanas.update_checker.check_for_updates()
end

function init_planes()
  local plane_manager = arxanas.planar.plane_manager.new(hotkey.new(HYPER, "c"))
  local default_plane = plane_manager:get_default_plane()
  default_plane:add_hotkey(hotkey.new(HYPER, "r", hydra.reload))

  local app_binder = plane_manager:add_plane(hotkey.new(HYPER, "g"))
  app_binder:add_hotkey_autodisable(hotkey.new(HYPER, "g", function(plane)
    hydra.alert("App binder!")
  end))
end

function main()
  hydra.alert("Reloaded hydra.")

  on_startup()
  init_planes()

  -- TODO: enable in regular mode.
  -- hotkey.bind(HYPER, "r", hydra.reload):enable()
end

main()

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
  plane_manager = arxanas.planar.plane_manager.new(HYPER, "c")
  default_plane = plane_manager:get_default_plane()
  default_plane:add_hotkey(HYPER, "r", hydra.reload)
end

function main()
  hydra.alert("Reloaded hydra.")

  on_startup()
  init_planes()

  -- TODO: enable in regular mode.
  -- hotkey.bind(HYPER, "r", hydra.reload):enable()
end

main()

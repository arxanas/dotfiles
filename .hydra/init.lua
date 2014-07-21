function douserfile(package_name)
  dofile(package.searchpath(package_name, package.path))
end
douserfile("appbinder")

APP_BINDINGS_FILE = os.getenv("HOME") .. "/.hydra/bindings"
HYPER = {"ctrl", "cmd"}

---
local mode = {}
local mode_metatable = setmetatable(mode, {__index=mode})

function mode:define_mode(mode_name)

end

function mode.new()
  return setmetatable({}, mode_metatable)
end
---

function main()
  hydra.alert("Reloaded hydra.")
  hotkey.bind(HYPER, "r", hydra.reload):enable()

  local appbinder = ext.appbinder.new({"ctrl", "cmd"}, APP_BINDINGS_FILE)
end

main()

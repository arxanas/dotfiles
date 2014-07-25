require "arxanas/init"

-- Symbols --
local app_binder = {}
local app_binder_metatable = {__index = app_binder}

-- Exports --
arxanas.app_binder = app_binder

-- App binder --

-- Construct the app binder.
--
--   plane_manager: The plane manager. The app binder will create the planes
--     necessary.
--   mods: The modifiers to apply to the app for switching.
--   switch_app_hotkey: The hotkey to press to enter the app-switching plane.
--   new_binding_hotkey: The hotkey to press to enter the app-binding plane.
function app_binder.new(
  plane_manager,
  mods,
  switch_app_hotkey,
  new_binding_hotkey
)
  local app_binder = setmetatable({
    _mods = mods,
    _switch_app_plane = plane_manager:add_plane(switch_app_hotkey),
    _new_binding_plane = plane_manager:add_plane(new_binding_hotkey),
  }, app_binder_metatable)

  app_binder._switch_app_plane.on_enter = function()
    hydra.alert("Ready to bind app...")
  end

  return app_binder
end

-- Bind an app to the plane and persist it.
--
--   key: The key to use with the 'mods' given.
--   app_name: The app to launch with 'application.launchorfocus'.
function app_binder:_bind_app(key, app_name)
  assert(self ~= nil)

  -- Add this binding. We index by 'key' so that we overwrite any previous
  -- bindings.
  local bindings = self:_get_bindings()
  bindings[key] = app_name
  self:_set_bindings(bindings)

  self._switch_app_plane:add_hotkey(hotkey.new(
    self._mods,
    key,
    function(plane)
      application.launchorfocus(app_name)
    end
  ))
end

-- Restore all bindings from settings.
function app_binder:_restore_bindings()
  for key, app_name in self:_get_bindings() do
    self:_bind_app(key, app_name)
  end
end

-- Return the bindings currently in use.
function app_binder:_get_bindings()
  assert(self ~= nil)

  local bindings = settings.get("arxanas.app_binder.bindings")

  if not bindings then
    return {}
  end

  return bindings
end

-- Persistently save the bindings.
function app_binder:_set_bindings(bindings)
  assert(self ~= nil)

  return settings.set("arxanas.app_binder.bindings", bindings)
end

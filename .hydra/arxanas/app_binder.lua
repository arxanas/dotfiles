require "arxanas/init"
douserfile "arxanas/key_dialog"

-- Symbols --
local app_binder = {}
local app_binder_metatable = {__index = app_binder}

-- Exports --
arxanas.app_binder = app_binder

-- Global --
local function show_message(message)
  hydra.alert(message, 0.7)
end

local key_dialog = arxanas.key_dialog

local function is_escape_key_info(key_info)
  if key_info.ctrl and key_info.key == "c" then
    return true
  -- Escape key.
  elseif string.byte(key_info.key) == 27 then
    return true
  else
    return false
  end
end

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
    _plane_manager = plane_manager,
    _mods = mods,
    _hotkeys = {},
    _switch_app_plane = plane_manager:add_plane(switch_app_hotkey),
    _new_binding_plane = plane_manager:add_plane(new_binding_hotkey),
  }, app_binder_metatable)

  app_binder:_restore_bindings()

  -- Prompt for the new binding.
  app_binder._new_binding_plane.on_enter = function()
    app_binder:_mode_bind_app()
  end

  return app_binder
end

function app_binder:_mode_bind_app()
  local current_window = window.focusedwindow()

  if not current_window then
    show_message("No focused window.")
    self._plane_manager:switch_to_default_plane()
    return
  end

  local app_name = current_window:application():title()

  key_dialog.show("Bind app to...", function(key_info)
    -- Restore context.
    current_window:focus()
    self._plane_manager:switch_to_default_plane()

    local key = key_info.key

    if is_escape_key_info(key_info) then
      show_message("Cancelled.")
    else
      show_message(string.format(
        "Bound app %s to key %s.",
        app_name,
        key
      ))

      self:_bind_app(key, app_name)
    end
  end)
end

-- Bind an app to the plane and persist it.
--
--   key: The key to use with the 'mods' given.
--   app_name: The app to launch with 'application.launchorfocus'.
function app_binder:_bind_app(key, app_name)
  assert(self ~= nil)

  key = key:lower()

  -- Add this binding. We index by 'key' so that we overwrite any previous
  -- bindings.
  local bindings = self:_get_bindings()
  bindings[key] = app_name
  self:_set_bindings(bindings)

  self._switch_app_plane:add_hotkey({
    mods = {},
    key = key,
    fn = function(plane)
      application.launchorfocus(app_name)
    end
  })

  self._switch_app_plane:add_hotkey({
    mods = self._mods,
    key = key,
    fn = function(plane)
      application.launchorfocus(app_name)
    end
  })
end

-- Restore all bindings from settings.
function app_binder:_restore_bindings()
  for key, app_name in pairs(self:_get_bindings()) do
    self:_bind_app(key, app_name)
  end
end

-- Return the bindings currently in use.
function app_binder:_get_bindings()
  assert(self ~= nil)

  local bindings = hydra.settings.get("arxanas.app_binder.bindings")

  if not bindings then
    return {}
  end

  return bindings
end

-- Persistently save the bindings.
function app_binder:_set_bindings(bindings)
  assert(self ~= nil)

  return hydra.settings.set("arxanas.app_binder.bindings", bindings)
end

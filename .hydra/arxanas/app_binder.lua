require "arxanas/init"

-- Symbols --
local app_binder = {}
local app_binder_metatable = {__index = app_binder}

local enter_key_dialog = {}
local enter_key_dialog_metatable = {__index = enter_key_dialog}

-- Exports --
arxanas.app_binder = app_binder

-- Global --
local function show_message(message)
  hydra.alert(message, 0.7)
end

local function is_escape_key_info(key_info)
  if key_info.ctrl and key_info.key == "c" then
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
    _switch_app_plane = plane_manager:add_plane(switch_app_hotkey),
    _new_binding_plane = plane_manager:add_plane(new_binding_hotkey),
  }, app_binder_metatable)

  app_binder._switch_app_plane.on_enter = function()
    app_binder:_mode_switch_apps()
  end

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

  local dialog = enter_key_dialog.new("Bind app to...", function(key_info)
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

function app_binder:_mode_switch_apps()
    local current_window = window.focusedwindow()

    local dialog = enter_key_dialog.new("Go to app...", function(key_info)
      key_info.key = key_info.key:lower()

      if is_escape_key_info(key_info) then
        show_message("Cancelled.")
      else
        local app_name = self:_get_bindings()[key_info.key]

        if not app_name then
          show_message(string.format(
            "Don't know app '%s'.",
            key_info.key
          ))
        else
          application.launchorfocus(app_name)
        end
      end
      self._plane_manager:switch_to_default_plane()
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
    mods = self._mods,
    key = key,
    fn = function(plane)
      application.launchorfocus(app_name)
    end
  })
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

-- Enter key dialog --

-- A dialog which prompts the user to enter a key.
--
--   callback: When the user enters a key, quits the dialog and sends that key
--     as the first argument to this callback.
function enter_key_dialog.new(message, callback)
  local enter_key_dialog = setmetatable({
    _message = message,
    _dialog = nil,
  }, enter_key_dialog_metatable)

  enter_key_dialog._dialog = enter_key_dialog:show()
  enter_key_dialog._dialog:keydown(function(key_info)
    callback(key_info)
    enter_key_dialog:destroy()
  end)

  return enter_key_dialog
end

-- Shows the enter-key dialog and returns the textfield.
function enter_key_dialog:show()
  assert(self ~= nil)

  local message = self._message
  local bg = "000000"
  local fg = "aaaaaa"

  local dialog = textgrid.create()
  dialog:sethastitlebar(false)
  dialog:sethasborder(false)
  dialog:sethasshadow(false)
  dialog:usefont("Menlo", 54)
  dialog:resize({w = message:len() + 2, h = 3})
  dialog:center()
  dialog:setbg(bg)
  dialog:setfg(fg)

  -- Write the message.
  for i = 1, string.len(message) do
    dialog:setchar(message:sub(i, i), i + 1, 2)
  end

  dialog:show()
  dialog:window():focus()

  return dialog
end

function enter_key_dialog:destroy()
  assert(self ~= nil)

  if self._dialog then
    self._dialog:destroy()
    self._dialog = nil
  end
end

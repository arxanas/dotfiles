require "arxanas/init"

-- Symbols --
local plane = {}
local plane_metatable = {__index=plane}

local plane_manager = {}
local plane_manager_metatable = {__index=plane_manager}

-- Exports --
arxanas.planar = {}
arxanas.planar.plane = plane
arxanas.planar.plane_manager = plane_manager

-- Plane --

-- Construct a new plane.
--
--   plane_manager: The plane manager which owns this plane.
function plane.new(plane_manager)
  return setmetatable({
    _hotkeys = {},
    _plane_manager = plane_manager,
    _enabled = false,
  }, plane_metatable)
end

-- Add a hotkey which can be triggered while this plane is enabled.
--
-- You can't add more than one function for a given hotkey.
--
--   mods: The modifier keys, as per 'hotkey.new'.
--   key: The key, as per 'hotkey.new'.
--   fn: The function to be called when the hotkey is pressed. It's given this
--       plane as the first argument.
function plane:add_hotkey(mods, key, fn)
  local new_hotkey = hotkey.new(mods, key, function()
    fn(self)
  end)

  if self._enabled then
    new_hotkey:enable()
  end

  table.insert(self._hotkeys, new_hotkey)
end

-- Add a hotkey just like 'add_hotkey', but once the hotkey has triggered,
-- disable this plane. Usually, hotkeys will disable the mode, so this will be
-- the right choice in many cases.
function plane:add_hotkey_autodisable(mods, key, fn)
  self:add_hotkey(mods, key, function(plane)
    fn(plane)
    plane:disable()
  end)
end

-- Enable this plane and all its hotkeys, and also disable any other planes
-- belonging to the same plane_manager.
function plane:enable()
  fnutils.each(self._hotkeys, hotkey.enable)
  self._enabled = true
end

-- Disable this plane and all its hotkeys.
function plane:disable()
  fnutils.each(self._hotkeys, hotkey.disable)
  self._enabled = false
end

-- Plane manager --

-- Construct the plane manager.
-- 
-- The plane manager keeps a list of planes. It has a 'default' plane, which it
-- will revert to when it doesn't have any other enabled plane. It can only
-- have one plane enabled at a time. Your 'global' hotkeys, or those which
-- should be active without a given mode enabled, should be attached to the
-- default plane.
--
-- The given mods + key are called the 'break key', which invoke the
-- currently-selected plane's 'on_break_key' method if it exists, and then
-- returns to the default plane. If the 'on_break_key' method is called and it
-- returns a falsey value, the break is cancelled, although this might be a bad
-- idea.
function plane_manager.new(mods, key)
  local plane_manager = setmetatable({
    _default_plane = nil, -- Set this below.
    _planes = {_default_plane},
  }, plane_manager_metatable)

  local default_plane = plane.new(plane_manager)
  plane_manager._default_plane = default_plane
  default_plane:enable()

  hotkey.bind(mods, key, function()
    plane_manager:switch_to_plane(default_plane)
  end)

  return plane_manager
end

-- Add a new plane for the given hotkey. Registers the plane (as disabled by
-- default) and returns it.
function plane_manager:add_plane(hotkey)
  local plane = plane.new(self)
  table.insert(self._planes, plane)
  return plane.new(self)
end

-- Get the default plane.
function plane_manager:get_default_plane()
  return self._default_plane
end

-- Switch to the given plane. Calls the 'on_leave' method of the current plane,
-- if it exists, and then disables that plane and enables the new plane and
-- calls its 'on_enter' method, if it exists. This happens even if we're
-- already on that plane.
--
--   plane: The plane object to switch to.
function plane_manager:switch_to_plane(plane)
  fnutils.each(self._planes, plane.disable)
  plane:enable()
end

-- Switch to the default plane.
function plane_manager:switch_to_default_plane()
  self:switch_to_plane(self._default_plane)
end

-- TODO: Implement events on_break, on_leave, on_enter
-- TODO: Make add_hotkey_autodisable the default.
